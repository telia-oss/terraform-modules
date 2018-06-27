## Terraform modules

[![Build Status](https://travis-ci.com/telia-oss/terraform-modules.svg?branch=master)](https://travis-ci.com/telia-oss/terraform-modules)

A collection of terraform modules that have not been published to [the registry](https://registry.terraform.io/modules/telia-oss) for one of the following reasons:
- When in doubt we don't publish.
- The module uses features that need to stabilize in the Terraform AWS provider.
- The module is not considered useful/generic enough to be published.

## Usage

To use a module, simply reference this repository as the source use `//<path>` to the subdirectory of a module:

```hcl
module "something" {
  source = "github.com/telia-oss/terraform-modules//something"
}
```

Because the repsitory and all modules are subject to changes, you'll want to reference a [release](https://github.com/telia-oss/terraform-modules/releases) in the source:

```hcl
module "something" {
  source = "github.com/TeliaSoneraNorge/divx-terraform-modules//bastion?ref=2018.06.27.1"
}
```

## Contributing

Contributions are welcome. Some guidelines that should be followed when authoring modules:

- Include a README.md that explains what the module does.
- Use the [standard module structure](https://www.terraform.io/docs/modules/create.html#standard-module-structure).
- All modules should take a `name_prefix` variable if resources can be named.
- All modules should take a `tags` variable if the resources can be tagged.
- Modules should not export variables or outputs that are never used.
- All variables and outputs should have a `description` (The description from the official docs will do in most cases).
- Modules should include a runnable example under `examples/default`.
- Be opinionated (don't expose variables that should never be tweaked etc.).
