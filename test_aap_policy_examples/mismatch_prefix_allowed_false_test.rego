package test_aap_policy_examples

import data.aap_policy_examples

test_matching_prefixes_allowed if {
	test_input := {
		"job_template": {"name": "prod_Job Template"},
		"inventory": {"name": "prod_Inventory"},
		"project": {"name": "prod_Project"},
		"credentials": [{"name": "prod_Credential"}],
	}
	aap_policy_examples.mismatch_prefix_allowed_false.allowed == true with input as test_input
}

test_mismatched_inventory_prefix_blocked if {
	test_input := {
		"job_template": {"name": "prod_Job Template"},
		"inventory": {"name": "dev_Inventory"},
		"project": {"name": "prod_Project"},
		"credentials": [{"name": "prod_Credential"}],
	}
	aap_policy_examples.mismatch_prefix_allowed_false.allowed == false with input as test_input
}

test_mismatched_project_prefix_blocked if {
	test_input := {
		"job_template": {"name": "prod_Job Template"},
		"inventory": {"name": "prod_Inventory"},
		"project": {"name": "dev_Project"},
		"credentials": [{"name": "prod_Credential"}],
	}
	aap_policy_examples.mismatch_prefix_allowed_false.allowed == false with input as test_input
}

test_mismatched_credential_prefix_blocked if {
	test_input := {
		"job_template": {"name": "prod_Job Template"},
		"inventory": {"name": "prod_Inventory"},
		"project": {"name": "prod_Project"},
		"credentials": [{"name": "dev_Credential"}],
	}
	aap_policy_examples.mismatch_prefix_allowed_false.allowed == false with input as test_input
}

test_violation_message if {
	test_input := {
		"job_template": {"name": "prod_Job Template"},
		"inventory": {"name": "dev_Inventory"},
		"project": {"name": "prod_Project"},
		"credentials": [{"name": "prod_Credential"}],
	}
	aap_policy_examples.mismatch_prefix_allowed_false.violations[0] == "Mismatch prefix between Inventory, Credentials and Project detected." with input as test_input
}

test_multiple_credentials_all_matching if {
	test_input := {
		"job_template": {"name": "prod_Job Template"},
		"inventory": {"name": "prod_Inventory"},
		"project": {"name": "prod_Project"},
		"credentials": [
			{"name": "prod_Credential1"},
			{"name": "prod_Credential2"},
		],
	}
	aap_policy_examples.mismatch_prefix_allowed_false.allowed == true with input as test_input
}
