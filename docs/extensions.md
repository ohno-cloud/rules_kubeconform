<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="kubeconform"></a>

## kubeconform

<pre>
kubeconform = use_extension("@rules_kubeconform//kubeconform:extensions.bzl", "kubeconform")
kubeconform.toolchain(<a href="#kubeconform.toolchain-version">version</a>)
kubeconform.schema_import(<a href="#kubeconform.schema_import-name">name</a>, <a href="#kubeconform.schema_import-resources">resources</a>, <a href="#kubeconform.schema_import-commit">commit</a>, <a href="#kubeconform.schema_import-github_repo">github_repo</a>, <a href="#kubeconform.schema_import-kube_version">kube_version</a>)
</pre>


**TAG CLASSES**

<a id="kubeconform.toolchain"></a>

### toolchain

**Attributes**

| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform.toolchain-version"></a>version |  -   | String | optional |  `""`  |

<a id="kubeconform.schema_import"></a>

### schema_import

**Attributes**

| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform.schema_import-name"></a>name |  Name of the resulting repository   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="kubeconform.schema_import-resources"></a>resources |  Resource schemas to import.   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> List of strings</a> | required |  |
| <a id="kubeconform.schema_import-commit"></a>commit |  Commit.   | String | required |  |
| <a id="kubeconform.schema_import-github_repo"></a>github_repo |  GitHub repo name.   | String | required |  |
| <a id="kubeconform.schema_import-kube_version"></a>kube_version |  Kubernetes version.   | String | required |  |


