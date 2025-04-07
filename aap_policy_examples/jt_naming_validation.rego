package aap_policy_examples

import rego.v1

# Default policy response indicating allowed status with no violations
default jt_naming_validation := {
    "allowed": true,
    "violations": [],
}

# Validate that job template name has correct organization and project name prefixes
jt_naming_validation := result if {
    # Extract values from input
    org_name := object.get(input, ["organization", "name"], "")
    project_name := object.get(input, ["project", "name"], "")
    jt_name := object.get(input, ["job_template", "name"], "")

    # Construct the expected prefix
    expected_prefix := concat("_", [org_name, project_name])

    # Check if job template name starts with expected prefix
    not startswith(jt_name, expected_prefix)

    result := {
        "allowed": false,
        "violations": [sprintf("Job template naming for '%v' does not comply with standards", [jt_name])]
    }
}
