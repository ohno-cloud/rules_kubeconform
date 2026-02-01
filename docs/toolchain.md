<!-- Generated with Stardoc: http://skydoc.bazel.build -->

This module implements the language-specific toolchain rule.

<a id="kubeconform_toolchain"></a>

## kubeconform_toolchain

<pre>
load("@rules_kubeconform//kubeconform:toolchain.bzl", "kubeconform_toolchain")

kubeconform_toolchain(<a href="#kubeconform_toolchain-name">name</a>, <a href="#kubeconform_toolchain-target_tool">target_tool</a>, <a href="#kubeconform_toolchain-target_tool_path">target_tool_path</a>)
</pre>

Defines a kubeconform compiler/runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="kubeconform_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="kubeconform_toolchain-target_tool"></a>target_tool |  A hermetically downloaded executable target for the target platform.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="kubeconform_toolchain-target_tool_path"></a>target_tool_path |  Path to an existing executable for the target platform.   | String | optional |  `""`  |


<a id="KubeconformInfo"></a>

## KubeconformInfo

<pre>
load("@rules_kubeconform//kubeconform:toolchain.bzl", "KubeconformInfo")

KubeconformInfo(<a href="#KubeconformInfo-target_tool_path">target_tool_path</a>, <a href="#KubeconformInfo-tool_files">tool_files</a>)
</pre>

Information about how to invoke the tool executable.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="KubeconformInfo-target_tool_path"></a>target_tool_path |  Path to the tool executable for the target platform.    |
| <a id="KubeconformInfo-tool_files"></a>tool_files |  Files required in runfiles to make the tool executable available.<br><br>May be empty if the target_tool_path points to a locally installed tool binary.    |


