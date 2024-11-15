#!/bin/sh

# Ensure we're in the root of the repository
cd "$(git rev-parse --show-toplevel)"

# Run hooks
./scripts/git/hooks/pre-commit/aggregate-release-notes.sh
