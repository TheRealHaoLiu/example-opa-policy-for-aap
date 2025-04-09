package aap_policy_examples

prefix_delimiter := "_"

# job_template_prefix extracts the substring before the first prefix_delimiter in `input.job_template.name`.
job_template_prefix := jtp if {
	parts := split(input.job_template.name, prefix_delimiter)
	jtp := parts[0]
}

# inventory_prefix extracts the substring before the first prefix_delimiter in `input.inventory.name`.
inventory_prefix := inv_pref if {
	parts := split(input.inventory.name, prefix_delimiter)
	inv_pref := parts[0]
}

# project_prefix extracts the substring before the first prefix_delimiter in `input.project.name`.
project_prefix := proj_pref if {
	parts := split(input.project.name, prefix_delimiter)
	proj_pref := parts[0]
}

# credentials_prefixes is a list of prefix values from each credential's name.
credentials_prefixes := [cprefix |
	cred := input.credentials[_] # iterate over credentials
	parts := split(cred.name, prefix_delimiter) # split name
	cprefix := parts[0] # grab the first part
]

# mismatch is true if either:
# 1. The project prefix != job template prefix, OR
# 2. The inventory prefix != job template prefix OR
# 3. Any credential's prefix != job template prefix.
mismatch if {
	project_prefix != job_template_prefix
}

mismatch if {
	inventory_prefix != job_template_prefix
}

mismatch if {
	some cp in credentials_prefixes
	cp != job_template_prefix
}

default mismatch_prefix_allowed_false := {
	"allowed": true,
	"violations": [],
}

mismatch_prefix_allowed_false := {
	"allowed": false,
	"violations": ["Mismatch prefix between Inventory, Credentials and Project detected."],
} if {
	mismatch
}
