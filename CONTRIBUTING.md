# How to Contribute

## Formatting

Starlark files should be formatted by buildifier.
We suggest using a pre-commit hook to automate this.
First [install pre-commit](https://pre-commit.com/#installation),
then run

```shell
pre-commit install
```

Otherwise later tooling on CI may yell at you about formatting/linting violations.

## Updating BUILD files

Some targets are generated from sources.
Currently this is just the `bzl_library` targets.
Run `bazel run //:gazelle` to keep them up-to-date.

## Using this as a development dependency of other rules

Use a `local_path_override` in the consumer's `MODULE.bazel`, as demonstrated
in `example/MODULE.bazel`:

```starlark
local_path_override(
    module_name = "rules_kubeconform",
    path = "/path/to/rules_kubeconform",
)
```

## Testing

Use Bazel 9.3.2, pinned in `.bazelversion` in both workspaces.

- Run `bazel test //...` from the repository root.
- Run `bazel test //... --test_output=errors --lockfile_mode=error` from `example/`.
- Regenerate API documentation with `bazel run //docs` after changing docstrings.

When intentionally changing the example's dependencies or extension inputs, run
without `--lockfile_mode=error` first and review the resulting lockfile changes.
