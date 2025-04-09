package aap_policy_examples

import rego.v1

# Define allowed values for specific keys in extra_vars
valid_extra_var_values := {"extra_var_key": ["allowed_value1", "allowed_value2"]}

# Default policy response indicating allowed status with no violations
default extra_vars_validation := {
	"allowed": true,
	"violations": [],
}

# Evaluate extra_vars_validation to check if extra_vars values are allowed
extra_vars_validation := result if {
	# Extract extra_vars from input, defaulting to empty object if missing
	input_extra_vars := object.get(input, ["extra_vars"], {})

	# Identify keys with disallowed values
	violating_keys := [key |
		valid_extra_var_values[key]
		not allowed_value(key, input_extra_vars[key])
	]

	# Check if there are any violations
	count(violating_keys) > 0

	result := {
		"allowed": false,
		"violations": [sprintf("extra_vars contain disallowed values for keys: %v. Allowed values: %v", [violating_keys, valid_extra_var_values])],
	}
}

# Check if a given value for a key is allowed
allowed_value(key, value) if {
	valid_extra_var_values[key][_] == value
}
