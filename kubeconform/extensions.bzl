"""Bzlmod setup for checksum-pinned Kubeconform toolchains and schemas."""

load("//kubeconform:repositories.bzl", "kubeconform_toolchain_repositories")
load("//kubeconform/private/rules:import.bzl", "kubeconform_import", "schema_downloads")

def _kubeconform_impl(ctx):
    toolchains = []
    schema_imports = []
    for mod in ctx.modules:
        if mod.tags.toolchain and not mod.is_root:
            fail("Toolchain being set in non-root module")
        toolchains.extend(mod.tags.toolchain)
        schema_imports.extend(mod.tags.schema_import)

    # Facts are keyed by the complete immutable URL, not by an apparent repo
    # name. Keep each checksum at the top level so facts merge independently.
    facts = {}
    for schema_import in schema_imports:
        commit = schema_import.commit
        if len(commit) != 40 or any([c not in "0123456789abcdef" for c in commit.elems()]):
            fail("schema_import.commit must be a full, lowercase Git commit SHA, not a branch or tag")
        integrities = {}
        downloads = schema_downloads(
            schema_import.github_repo,
            commit,
            schema_import.kube_version,
            schema_import.resources,
        )
        for file_name, url in downloads.items():
            key = "schema-integrity-v1:" + url
            if key not in facts:
                integrity = ctx.facts.get(key)
                if not integrity:
                    result = ctx.download(
                        url = url,
                        output = "schema-discovery.json",
                    )
                    integrity = result.integrity
                facts[key] = integrity
            integrities[file_name] = facts[key]
        kubeconform_import(
            name = schema_import.name,
            github_repo = schema_import.github_repo,
            commit = commit,
            kube_version = schema_import.kube_version,
            resources = schema_import.resources,
            integrities = integrities,
        )

    for toolchain in toolchains:
        kubeconform_toolchain_repositories(
            name = toolchain.name,
            kubeconform_version = toolchain.version,
            checksums = toolchain.checksums,
        )

    # Discovery is trust-on-first-use. Preserve its checksums in the lockfile;
    # do not mark this extension reproducible and thereby omit its lock entry.
    return ctx.extension_metadata(facts = facts)

_toolchain = tag_class(attrs = {
    "name": attr.string(
        default = "kubeconform_toolchain",
        doc = "Name of the toolchain registration repository. Use distinct names when selecting multiple versions.",
    ),
    "version": attr.string(doc = "Kubeconform release version without a v prefix.", mandatory = True),
    "checksums": attr.string_dict(
        doc = """Platform-to-SHA-256 overrides. Versions 0.6.7, 0.7.0, and 0.8.0 have built-in
checksums for macOS/Linux amd64 and arm64; 0.6.7 and 0.7.0 also support linux-386.
Other releases require entries for each platform to register. Only platforms
with checksums are registered, and only the selected execution platform is downloaded.""",
    ),
})

_import = tag_class(attrs = {
    "name": attr.string(
        doc = "Name of the resulting repository.",
        mandatory = True,
    ),
    "github_repo": attr.string(
        doc = "GitHub repository in owner/name form.",
        mandatory = True,
    ),
    "commit": attr.string(
        doc = "Full, lowercase Git commit SHA. Discovered checksums are recorded in module facts.",
        mandatory = True,
    ),
    "kube_version": attr.string(
        doc = "Kubernetes version.",
        mandatory = True,
    ),
    "resources": attr.string_list_dict(
        doc = "Resource schemas to import.",
        mandatory = True,
    ),
})

kubeconform = module_extension(
    doc = """Sets up checksum-pinned Kubeconform toolchains and schema repositories.

Schema imports require a full lowercase Git commit SHA. Checksums are discovered
on first use (trust-on-first-use), saved as module facts in MODULE.bazel.lock,
and reused to verify subsequent downloads. Commit and review lockfile updates.
No per-schema checksum maintenance is required in MODULE.bazel.

Only requested schemas are downloaded. A full archive of the example's upstream
revision exceeded 1 GiB expanded before download completion, so selective fetches
avoid downloading and extracting the entire repository.
""",
    implementation = _kubeconform_impl,
    tag_classes = {"toolchain": _toolchain, "schema_import": _import},
)
