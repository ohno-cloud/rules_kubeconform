<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies

<a id="kubeconform_register_toolchains"></a>

## kubeconform_register_toolchains

<pre>
load("@rules_kubeconform//kubeconform:repositories.bzl", "kubeconform_register_toolchains")

kubeconform_register_toolchains(<a href="#kubeconform_register_toolchains-name">name</a>, <a href="#kubeconform_register_toolchains-register">register</a>, <a href="#kubeconform_register_toolchains-checksums">checksums</a>, <a href="#kubeconform_register_toolchains-kwargs">**kwargs</a>)
</pre>

Convenience macro for users which does typical setup.

- create a repository for each built-in platform like "kubeconform_linux_amd64" -
  this repository is lazily fetched when kubeconform is needed for that platform.
- create a repository exposing toolchains for each platform like "kubeconform_platforms"
- register a toolchain pointing at each platform
Users can avoid this macro and do these steps themselves, if they want more control.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="kubeconform_register_toolchains-name"></a>name |  base name for all created repos, like "kubeconform0_4_12"   |  none |
| <a id="kubeconform_register_toolchains-register"></a>register |  Whether to register toolchains (False when called by a module extension).   |  `True` |
| <a id="kubeconform_register_toolchains-checksums"></a>checksums |  Optional platform-to-SHA-256 mapping, overriding built-in release checksums. Version 0.6.7 is built in; other releases need entries for every platform in PLATFORMS. Platform archives remain lazily fetched.   |  `None` |
| <a id="kubeconform_register_toolchains-kwargs"></a>kwargs |  passed to each kubeconform_archive call; includes kubeconform_version   |  none |


<a id="rules_kubeconform_dependencies"></a>

## rules_kubeconform_dependencies

<pre>
load("@rules_kubeconform//kubeconform:repositories.bzl", "rules_kubeconform_dependencies")

rules_kubeconform_dependencies()
</pre>





<a id="kubeconform_archive"></a>

## kubeconform_archive

<pre>
load("@rules_kubeconform//kubeconform:repositories.bzl", "kubeconform_archive")

kubeconform_archive(<a href="#kubeconform_archive-name">name</a>, <a href="#kubeconform_archive-integrity">integrity</a>, <a href="#kubeconform_archive-kubeconform_version">kubeconform_version</a>, <a href="#kubeconform_archive-platform">platform</a>, <a href="#kubeconform_archive-sha256">sha256</a>)
</pre>

Downloads a checksum-pinned Kubeconform release.

Requires Bazel 9 or newer and either sha256 or integrity. Unlike the legacy
kubeconform_repositories rule, this does not query the mutable GitHub releases
API and declares its output reproducible for repository-content caching.

Consumers opt into the experimental remote cache with the startup flag
--experimental_remote_repo_contents_cache and their own --remote_cache or
--remote_executor configuration. Cache misses still execute the repository rule
locally, and cache population requires client-side cache-write permission.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform_archive-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="kubeconform_archive-integrity"></a>integrity |  Expected archive checksum in Subresource Integrity format.   | String | optional |  `""`  |
| <a id="kubeconform_archive-kubeconform_version"></a>kubeconform_version |  Release version without a v prefix.   | String | required |  |
| <a id="kubeconform_archive-platform"></a>platform |  Execution platform of the release archive.   | String | required |  |
| <a id="kubeconform_archive-sha256"></a>sha256 |  Expected archive SHA-256; required unless integrity is supplied.   | String | optional |  `""`  |


<a id="kubeconform_repositories"></a>

## kubeconform_repositories

<pre>
load("@rules_kubeconform//kubeconform:repositories.bzl", "kubeconform_repositories")

kubeconform_repositories(<a href="#kubeconform_repositories-name">name</a>, <a href="#kubeconform_repositories-kubeconform_version">kubeconform_version</a>, <a href="#kubeconform_repositories-platform">platform</a>)
</pre>

Legacy, unpinned Kubeconform release downloader.

This rule queries the mutable GitHub releases API and does not declare its output
reproducible. Prefer kubeconform_archive for checksum verification and Bazel 9
repository-content caching.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform_repositories-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="kubeconform_repositories-kubeconform_version"></a>kubeconform_version |  Release version without a v prefix.   | String | required |  |
| <a id="kubeconform_repositories-platform"></a>platform |  Execution platform of the release archive.   | String | required |  |


