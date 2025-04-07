package test_aap_policy_examples

import data.aap_policy_examples

test_valid_jt_naming_allowed if {
    test_input := {
        "organization": {"name": "org1"},
        "project": {"name": "proj1"},
        "job_template": {"name": "org1_proj1_my_template"},
    }
    aap_policy_examples.jt_naming_validation.allowed == true with input as test_input
}

test_invalid_jt_naming_not_allowed if {
    test_input := {
        "organization": {"name": "org1"},
        "project": {"name": "proj1"},
        "job_template": {"name": "my_template"},
    }
    aap_policy_examples.jt_naming_validation.allowed == false with input as test_input
}

test_violation_message if {
    test_input := {
        "organization": {"name": "org1"},
        "project": {"name": "proj1"},
        "job_template": {"name": "my_template"},
    }
    aap_policy_examples.jt_naming_validation.violations[0] == "Job template naming for 'my_template' does not comply with standards" with input as test_input
}
