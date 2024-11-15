#!/bin/sh

# Ensure we're in the root of the repository
cd "$(git rev-parse --show-toplevel)"

# Ensure git hooks directory exists
mkdir -p .git/hooks

# Ensure hooks are executable
chmod u+x scripts/git/hooks/pre-commit/aggregate-release-notes.sh

chmod u+x scripts/git/hooks/pre-commit.sh

# Link hooks
ln -s scripts/git/hooks/pre-commit.sh .git/hooks/pre-commit
