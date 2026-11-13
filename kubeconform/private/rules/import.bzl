"kubeconform_import rule"

_DOC = """Imports only the requested Kubeconform schemas.

With a complete integrities mapping, downloads are verified and the repository
is declared reproducible for Bazel 9 repository-content caching. Without one,
the rule remains usable but does not declare itself reproducible; its metadata
reports the checksums needed to pin it. Prefer the module extension, which
discovers these checksums and preserves them in MODULE.bazel.lock automatically.
"""

_ATTRS = {
    "github_repo": attr.string(
        doc = "GitHub repo name.",
        mandatory = True,
    ),
    "commit": attr.string(
        doc = "Commit.",
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
    "integrities": attr.string_dict(
        doc = "Schema filename-to-SRI checksum mapping. The module extension discovers and records these automatically.",
    ),
}

def schema_downloads(github_repo, commit, kube_version, resources):
    """Computes the downloads needed for an import.

    Args:
        github_repo: GitHub repository in owner/name form.
        commit: Git revision containing the schemas.
        kube_version: Kubernetes schema version.
        resources: Resource kind-to-API-version-list mapping.

    Returns:
        A deduplicated mapping of schema filenames to their download URLs.
    """

    # Keep URL components literal so an apparently commit-pinned URL cannot
    # traverse to a path that refers to mutable content.
    components = github_repo.split("/")
    allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_."
    if len(components) != 2:
        fail("github_repo must be a GitHub repository in owner/name form")
    for part in components:
        if not part or part in [".", ".."] or any([c not in allowed for c in part.elems()]):
            fail("github_repo must be a GitHub repository in owner/name form")
    if not kube_version or any([c not in allowed for c in kube_version.elems()]):
        fail("kube_version must be a literal version, not a path or URL")
    downloads = {}
    for res, versions in resources.items():
        for version in versions:
            file_name = "{}-{}.json".format(res.lower(), version.lower().replace("/", "-"))
            if any([c not in allowed for c in file_name.elems()]):
                fail("Resource names and versions must produce a plain schema filename")
            downloads[file_name] = "https://raw.githubusercontent.com/{}/{}/v{}-standalone-strict/{}".format(
                github_repo,
                commit,
                kube_version,
                file_name,
            )
    return downloads

def _impl(repository_ctx):
    downloads = schema_downloads(
        repository_ctx.attr.github_repo,
        repository_ctx.attr.commit,
        repository_ctx.attr.kube_version,
        repository_ctx.attr.resources,
    )
    integrities = {}
    pinned = True
    for file_name, url in downloads.items():
        integrity = repository_ctx.attr.integrities.get(file_name, "")
        if not integrity:
            pinned = False
        result = repository_ctx.download(
            output = file_name,
            url = url,
            integrity = integrity,
        )
        integrities[file_name] = result.integrity
    repository_ctx.file("BUILD.bazel", content = """
package(default_visibility = ["//visibility:public"])
filegroup(
    name = "schemas",
    srcs = glob(["*.json"]),
)
    """, executable = False)
    if pinned:
        return repository_ctx.repo_metadata(reproducible = True)
    return repository_ctx.repo_metadata(attrs_for_reproducibility = {"integrities": integrities})

kubeconform_import = repository_rule(
    doc = _DOC,
    implementation = _impl,
    attrs = _ATTRS,
)
