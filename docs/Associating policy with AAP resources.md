# Associating Policies with AAP Resources

## Table of Contents
- [Overview](#overview)
- [Understanding OPA Packages and Rules](#understanding-opa-packages-and-rules)
- [Associating Policies with AAP Resources](#associating-policies-with-aap-resources)
- [Effects of Policy Association](#effects-of-policy-association)

## Overview

Ansible Automation Platform (AAP) allows you to associate Open Policy Agent (OPA) policies with various resources to enforce security and compliance controls. This guide explains how to associate policies with AAP resources and their effects.

## Understanding OPA Packages and Rules

### OPA Package Structure

An OPA policy is organized in packages, which are namespaced collections of rules. The basic structure of an OPA policy looks like this:

```rego
package aap_policy_examples  # Package name

import rego.v1  # Import required for Rego v1 syntax

# Rules define the policy logic
allowed := {
    "allowed": true,
    "violations": []
}
```

### Key Components

1. **Package Declaration**: Defines the namespace for your policy
2. **Rules**: Define the policy logic and return a decision object

Note that these components comprise the OPA policy name, which is formatted as `{package}/{rule}`. You will enter the OPA policy name when configuring enforcement points.

## Associating Policies with AAP Resources

### Available Enforcement Points

You can create an enforcement point by associating a policy with the following AAP resources:

1. **Organizations**
   - Affects all job templates within an Organization
   - Provides broad control over automation within organizational boundaries

2. **Inventories**
   - Affects all jobs using a specified Inventory
   - Controls access to specific infrastructure resources

3. **Job Templates**
   - Affects jobs launched from a specific Job Template
   - Provides granular control over specific automation tasks

### How to Associate a Policy with a Resource

#### 1. Job Template Level

To associate a policy with a Job Template:
1. Navigate to **Templates** in the AAP UI
2. Select or create a Job Template
3. In the Job Template edit form, locate the **OPA policy** field
4. Enter the policy in the format `{package}/{rule}`
   - Example: `aap_policy_examples/allowed_false`
5. Click "Save job template" to apply the policy

#### 2. Inventory Level

To associate a policy with an Inventory:
1. Navigate to **Inventories** under Infrastructure
2. Select or create an Inventory
3. In the Inventory edit form, find the **OPA policy** field
4. Enter the policy in the format `{package}/{rule}`
5. The policy will be enforced for all jobs using this inventory

#### 3. Organization Level

To associate a policy with an Organization:
1. Navigate to **Organizations** under Access Management
2. Select or create an Organization
3. In the Organization edit form, locate the **OPA policy** field
4. Enter the policy in the format `{package}/{rule}`
5. The policy will affect all job templates within the organization

Note: For all resources, the OPA policy field format must follow the pattern `{package}/{rule}`. This is a required format and will be validated by the UI.

## Effects of Policy Association

### Job Execution Behavior

Policy evaluation is integrated into the job lifecycle as a dedicated phase called `evaluate_policy`. Here's how it works:

1. **Job Launch Sequence**:
   - User initiates a job launch
   - Before playbook execution begins, the job enters the `evaluate_policy` phase

2. **Policy Collection**:
   During the `evaluate_policy` phase, AAP gathers all relevant policies from:
   - The organization that owns the job template
   - The inventory being used in the job
   - The job template the job was launched from

3. **Policy Evaluation**:
   - AAP sends the collected policies to the configured OPA server for evaluation
   - Each policy is evaluated against the job context
   - The job will be blocked if any policy evaluation:
     - Returns `"allowed": false`, or
     - Fails to evaluate

4. **Job State Transition**:
   - If all policies allow the job:
     - The job proceeds to playbook execution
   - If any policy blocks the job:
     - The job transitions to "Error" state
     - Playbook execution is prevented
     - Error messages from policy violations are recorded 