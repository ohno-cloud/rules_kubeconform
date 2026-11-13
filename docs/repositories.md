<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Checksum-pinned repository rules and toolchain setup for Bzlmod extensions.

<a id="kubeconform_toolchain_repositories"></a>

## kubeconform_toolchain_repositories

<pre>
load("@rules_kubeconform//kubeconform:repositories.bzl", "kubeconform_toolchain_repositories")

kubeconform_toolchain_repositories(<a href="#kubeconform_toolchain_repositories-name">name</a>, <a href="#kubeconform_toolchain_repositories-kubeconform_version">kubeconform_version</a>, <a href="#kubeconform_toolchain_repositories-checksums">checksums</a>)
</pre>

Creates checksum-pinned toolchain repositories from a module extension.

Creates a registration repository named name, plus version- and platform-qualified
archive repositories that are lazily fetched when needed.

Register the generated toolchains with register_toolchains in MODULE.bazel.
Normally users configure these repositories through the kubeconform extension.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="kubeconform_toolchain_repositories-name"></a>name |  Name of the toolchain registration repository and prefix for its archives.   |  none |
| <a id="kubeconform_toolchain_repositories-kubeconform_version"></a>kubeconform_version |  Release version without a v prefix.   |  none |
| <a id="kubeconform_toolchain_repositories-checksums"></a>checksums |  Optional platform-to-SHA-256 mapping, overriding built-in release checksums.   |  `None` |


<a id="kubeconform_archive"></a>

## kubeconform_archive

<pre>
load("@rules_kubeconform//kubeconform:repositories.bzl", "kubeconform_archive")

kubeconform_archive(<a href="#kubeconform_archive-name">name</a>, <a href="#kubeconform_archive-integrity">integrity</a>, <a href="#kubeconform_archive-kubeconform_version">kubeconform_version</a>, <a href="#kubeconform_archive-platform">platform</a>, <a href="#kubeconform_archive-sha256">sha256</a>)
</pre>

Downloads a checksum-pinned Kubeconform release.

Requires either sha256 or integrity. This does not query the
mutable GitHub releases API and declares its output reproducible for
repository-content caching. Use it from a module extension or via use_repo_rule
in MODULE.bazel.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform_archive-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="kubeconform_archive-integrity"></a>integrity |  Expected archive checksum in Subresource Integrity format.   | String | optional |  `""`  |
| <a id="kubeconform_archive-kubeconform_version"></a>kubeconform_version |  Release version without a v prefix.   | String | required |  |
| <a id="kubeconform_archive-platform"></a>platform |  Execution platform of the release archive.   | String | required |  |
| <a id="kubeconform_archive-sha256"></a>sha256 |  Expected archive SHA-256; required unless integrity is supplied.   | String | optional |  `""`  |


