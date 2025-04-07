package test_aap_policy_examples

import data.aap_policy_examples

test_valid_main_branch_allowed if {
    test_input := {
        "project": {
            "scm_branch": "main"
        }
    }
    aap_policy_examples.project_scm_branch_validation.allowed == true with input as test_input
}

test_valid_v1_branch_allowed if {
    test_input := {
        "project": {
            "scm_branch": "v1"
        }
    }
    aap_policy_examples.project_scm_branch_validation.allowed == true with input as test_input
}

test_invalid_branch_blocked if {
    test_input := {
        "project": {
            "scm_branch": "develop"
        }
    }
    aap_policy_examples.project_scm_branch_validation.allowed == false with input as test_input
}

test_invalid_branch_violation_message if {
    test_input := {
        "project": {
            "scm_branch": "develop"
        }
    }
    aap_policy_examples.project_scm_branch_validation.violations[0] == "Invalid branch: develop. Only named 'main' or 'v1' branches are allowed." with input as test_input
}
