<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Bzlmod setup for checksum-pinned Kubeconform toolchains and schemas.

<a id="kubeconform"></a>

## kubeconform

<pre>
kubeconform = use_extension("@rules_kubeconform//kubeconform:extensions.bzl", "kubeconform")
kubeconform.toolchain(<a href="#kubeconform.toolchain-checksums">checksums</a>, <a href="#kubeconform.toolchain-version">version</a>)
kubeconform.schema_import(<a href="#kubeconform.schema_import-name">name</a>, <a href="#kubeconform.schema_import-resources">resources</a>, <a href="#kubeconform.schema_import-commit">commit</a>, <a href="#kubeconform.schema_import-github_repo">github_repo</a>, <a href="#kubeconform.schema_import-kube_version">kube_version</a>)
</pre>

Sets up checksum-pinned Kubeconform toolchains and schema repositories.

Schema imports require a full lowercase Git commit SHA. Checksums are discovered
on first use (trust-on-first-use), saved as module facts in MODULE.bazel.lock,
and reused to verify subsequent downloads. Commit and review lockfile updates.
No per-schema checksum maintenance is required in MODULE.bazel.

Only requested schemas are downloaded. A full archive of the example's upstream
revision exceeded 1 GiB expanded before download completion, so selective fetches
avoid downloading and extracting the entire repository.


**TAG CLASSES**

<a id="kubeconform.toolchain"></a>

### toolchain

**Attributes**

| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform.toolchain-checksums"></a>checksums |  Platform-to-SHA-256 overrides. Version 0.6.7 has built-in checksums; other releases require entries for darwin-amd64, darwin-arm64, linux-amd64, linux-arm64, and linux-386. Only the selected execution platform is downloaded.   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | optional |  `{}`  |
| <a id="kubeconform.toolchain-version"></a>version |  Kubeconform release version without a v prefix.   | String | required |  |

<a id="kubeconform.schema_import"></a>

### schema_import

**Attributes**

| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform.schema_import-name"></a>name |  Name of the resulting repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="kubeconform.schema_import-resources"></a>resources |  Resource schemas to import.   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> List of strings</a> | required |  |
| <a id="kubeconform.schema_import-commit"></a>commit |  Full, lowercase Git commit SHA. Discovered checksums are recorded in module facts.   | String | required |  |
| <a id="kubeconform.schema_import-github_repo"></a>github_repo |  GitHub repository in owner/name form.   | String | required |  |
| <a id="kubeconform.schema_import-kube_version"></a>kube_version |  Kubernetes version.   | String | required |  |


