package aap_policy_examples

import rego.v1

# Default policy response indicating allowed status with no violations
default organization_inventory_validation := {
    "allowed": true,
    "violations": [],
}

# Validate that only "Default" can use "Demo Inventory"
organization_inventory_validation := result if {
    # Extract values from input
    inventory_name := object.get(input, ["inventory", "name"], "")
    org_name := object.get(input, ["organization", "name"], "")

    # Check if inventory is "Demo Inventory"
    inventory_name == "Demo Inventory"

    # Check if organization is not "Default"
    org_name != "Default"

    result := {
        "allowed": false,
        "violations": ["Only the 'Default' organization should use the 'Demo Inventory' inventory"],
    }
}
