package aap_policy_examples

import rego.v1

# Define list of allowed GitHub repositories
allowed_github_repos := [
    "organization/repo1",
    "organization/repo2"
]

# Default policy response indicating allowed status with no violations
default github_repo_validation := {
    "allowed": true,
    "violations": [],
}

# Validate that the GitHub repository is in the whitelist
github_repo_validation := result if {
    # Extract SCM URL from input
    scm_url := object.get(input, ["project", "scm_url"], "")

    # Extract repository path from URL
    parts := split(scm_url, "/")
    count_parts := count(parts)
    org := parts[count_parts-2]
    repo_name := trim_suffix(parts[count_parts-1], ".git")
    repo_path := concat("/", [org, repo_name])

    # Check if repo path is not in the whitelist
    not repo_path in allowed_github_repos

    result := {
        "allowed": false,
        "violations": [sprintf("Repository '%v' is not in the allowed list", [repo_path])],
    }
}
