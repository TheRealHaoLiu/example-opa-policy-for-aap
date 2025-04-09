# Example OPA Policies for Ansible Automation Platform

This repository contains example policies and use cases demonstrating how to use Policy as Code feature in Ansible Automation Platform (AAP). These examples will guide you through implementing various policy enforcement scenarios using Open Policy Agent (OPA).

## Overview

Policy as Code allows you to define and enforce policies across your Ansible Automation Platform using OPA and the Rego language. This repository provides practical examples of common policy enforcement scenarios.

## Prerequisites

- Ansible Automation Platform 2.5 or later with the `FEATURE_POLICY_AS_CODE_ENABLED` feature flag set to `True` 
  - see [Enabling Policy as Code Feature](docs/Enabling%20Policy%20as%20Code%20feature.md) for more information
- An OPA server that's reachable from your AAP deployment
  - See [Deploy OPA server on OpenShift](docs/Deploy%20OPA%20server%20on%20OpenShift.md) for development and testing setup
  - See [Deploy OPA server with Podman](docs/Deploy%20OPA%20server%20with%20Podman.md) for development and testing setup
- Configured AAP with settings required for connecting to your OPA server 
  - see [Configuring OPA Server Connection](docs/Configuring%20OPA%20Server%20Connection.md) for more information
- General knowledge around OPA and the Rego language 
  - see [Official OPA Documentation](https://www.openpolicyagent.org/docs/latest/) for more information

For detailed setup instructions, see "Setting up Policy as Code for Ansible Automation Platform" in the official documentation.

## Repository Structure

```
.
├── aap_policy_examples/     # Example policy implementations
├── example_input_data/     # Sample input data for testing
├── test_aap_policy_examples/ # Test cases and validation
├── openshift/             # OpenShift-specific configurations
├── tools/                # Utility scripts and tools
├── bin/                  # Binary and executable files
├── .github/             # GitHub-specific configurations
├── POLICY_INPUT_DATA.md # Documentation of input data structure
└── POLICY_OUTPUT_DATA.md # Documentation of output data structure
```

## Example Policies

The repository includes several example policies demonstrating different use cases:

1. [Prevent job execution at various policy enforcement points](1.Prevent%20job%20execution%20at%20different%20policy%20enforcement%20points.md)
2. [Prevent job execution by platform admin](2.Prevent%20job%20execution%20by%20platform%20admin.md)
3. [Prevent job execution during maintenance window](3.Prevent%20job%20execution%20during%20maintenance%20window.md)
4. [Prevent job execution using credential with no Organization](4.Prevent%20job%20execution%20using%20credential%20with%20no%20Organization.md)
5. [Prevent job execution using mismatching resources](5.Prevent%20job%20execution%20using%20mismatching%20resources.md)
6. Enforce extra_vars based policies
   - [Prevent job execution using extra vars with non approved vars](6a.Prevent%20job%20execution%20using%20extra%20vars%20with%20non%20approved%20vars.md) - Validate keys for extra_vars
   - [Prevent job execution using extra vars with non approved values](6b.Prevent%20job%20execution%20using%20extra%20vars%20with%20non%20approved%20values.md) - Validate values for extra_vars 
   - [Prevent job execution based on user limitations for extra vars](6c.Prevent%20job%20execution%20based%20on%20user%20limitations%20for%20extra%20vars.md) - Team-based access control on extra_vars
7. Source code controls
   - [Only allow approved Github source repos](7a.Only%20allow%20approved%20Github%20repos.md) - Only allow approved source repos
   - [Only allow approved Github source repo branches](7b.Only%20allow%20certain%20Git%20branches.md) - Only allow approved source repo branches
8. [Enforce Naming Standards](8.Enforce%20Job%20Template%20Naming%20Standards.md) - ensure Job Template name conforms to our standards
9. [Restrict usage of an Inventory to an Organization](9.Restrict%20Inventory%20use%20to%20an%20organization.md) - restrict inventory usage by organization

Each policy example includes:
- Detailed explanation of the use case
- Example Rego policy implementation
- Sample input and output data
- Testing instructions

## Getting Started

1. Clone this repository
2. Review the example policies in the `aap_policy_examples/` directory
3. Use the provided test cases in `test_aap_policy_examples/` to validate your policies
4. Customize the policies according to your needs

## Testing

The repository includes test cases and example input data to help you validate your policies. See the `test_aap_policy_examples/` directory for more details.

## Documentation

- [POLICY_INPUT_DATA.md](POLICY_INPUT_DATA.md): Contains detailed information about the input data structure used by the policies
- [POLICY_OUTPUT_DATA.md](POLICY_OUTPUT_DATA.md): Contains detailed information about the output data structure
- [Associating Policies with AAP Resources](docs/Associating%20policy%20with%20AAP%20resources.md): Guide on how to associate OPA policies with AAP resources

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is dedicated to the public domain under The Unlicense. See the LICENSE file for details.

The Unlicense is a template for disclaiming copyright monopoly interest in software you've written; in other words, it is a template for dedicating your software to the public domain.
