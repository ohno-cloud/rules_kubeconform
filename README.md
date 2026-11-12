# Bazel rules for kubeconform

Validate Kubernetes manifests with [Kubeconform](https://github.com/yannh/kubeconform).
The checksum-pinned APIs require **Bazel 9 or newer**.

## Installation with Bzlmod

Add the dependency and extension to `MODULE.bazel` (use the appropriate published
ruleset version):

```starlark
bazel_dep(name = "rules_kubeconform", version = "0.0.0")

kubeconform = use_extension("@rules_kubeconform//kubeconform:extensions.bzl", "kubeconform")
kubeconform.toolchain(version = "0.6.7")
kubeconform.schema_import(
    name = "kubernetes_json_schema",
    github_repo = "yannh/kubernetes-json-schema",
    commit = "f5e9af7e64b63484e2bf2ee28afee3f3f8e2e9b1",
    kube_version = "1.31.0",
    resources = {"Deployment": ["apps/v1"]},
)
use_repo(kubeconform, "kubernetes_json_schema", "kubeconform_0_6_7_toolchains")
register_toolchains("@kubeconform_0_6_7_toolchains//...")
```

Then declare a test in `BUILD.bazel`:

```starlark
load("@rules_kubeconform//kubeconform:defs.bzl", "kubeconform_lint_test")

kubeconform_lint_test(
    name = "lint",
    srcs = glob(["*.yaml"]),
    schema_locations = ["@kubernetes_json_schema//:schemas"],
    strict = True,
)
```

See [`example/`](example/) for a runnable consumer workspace.

## Documentation

- [Module extension](docs/extensions.md)
- [Repository rules](docs/repositories.md)
- [Validation rules](docs/rules.md)
- [Contributing and testing](CONTRIBUTING.md)

## Platforms

Toolchains currently support macOS and Linux. Native Windows execution is not
supported.
