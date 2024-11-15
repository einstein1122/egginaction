#Requires -Version 5.1

# Ensure we're in the root of the repository
Set-Location -Path "$(git.exe rev-parse --show-toplevel)"

# Ensure git hooks directory exists
New-Item -Force -ItemType Directory -Path .git\hooks

# Copy hooks
Copy-Item -Force -Path scripts\git\hooks\pre-commit.sh -Destination .git\hooks\pre-commit
