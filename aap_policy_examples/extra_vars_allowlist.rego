package aap_policy_examples

import rego.v1

# Define the allowed keys for extra_vars
allowed_extra_var_keys := ["allowed"]

# Default policy result: allowed (no violations)
default extra_vars_allowlist := {
	"allowed": true,
	"violations": [],
}

# Evaluate extra_vars_allowlist, checking if provided extra_vars contain any keys not allowed
extra_vars_allowlist := result if {
	# Extract extra_vars from input, defaulting to empty object if missing
	input_extra_var_keys := object.get(input, ["extra_vars"], {})

	# Identify keys in extra_vars that are not in the allowed list
	violating_keys := [key | input_extra_var_keys[key]; not allowed_key(key)]

	# If violating keys are found, construct result indicating disallowed status and violations
	count(violating_keys) > 0

	result := {
		"allowed": false,
		"violations": [sprintf("Following extra_vars are not allowed: %v. Allowed keys: %v", [violating_keys, allowed_extra_var_keys])],
	}
}

# Helper function: Checks if a given key is in the allowed_extra_var_keys list
allowed_key(key) if {
	allowed_extra_var_keys[_] == key
}
