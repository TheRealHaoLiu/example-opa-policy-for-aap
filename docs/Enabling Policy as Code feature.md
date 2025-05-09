# Enabling Policy as Code Feature in Ansible Automation Platform

This document describes how to enable feature flags in Ansible Automation Platform (AAP) for different installation types.

## OpenShift Installation

For OpenShift installations, you need to modify the `AnsibleAutomationPlatform` custom resource. Add the following to the `spec` section:

```yaml
spec:
  feature_flags:
    FEATURE_POLICY_AS_CODE_ENABLED: True
```

After applying the changes, wait for the operator to complete the update process. The operator will automatically handle the necessary service restarts and configuration updates.

## RPM Installation

For RPM-based installations, modify your inventory file used by the installer and add:

```yaml
feature_flags: { "FEATURE_POLICY_AS_CODE_ENABLED"": True }
```

After modifying the inventory file, you will need to rerun the installer to apply the changes.

## Containerized Installation

For containerized installations, modify your inventory file used by the installer and add:

```yaml
feature_flags: { "FEATURE_POLICY_AS_CODE_ENABLED"": True }
```

After modifying the inventory file, you will need to rerun the installer to apply the changes.

## Verifying Feature Flag Status

To verify that the feature flag is enabled, you can check the feature flags state endpoint:

```
https://<your-aap-host>/api/controller/v2/feature_flags_state/
```

This endpoint will return a JSON response containing the current state of all feature flags, including `FEATURE_POLICY_AS_CODE_ENABLED`. 
