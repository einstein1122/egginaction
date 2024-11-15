#!/bin/sh

# Ensure we're in the root of the repository
cd "$(git rev-parse --show-toplevel)"

# Initialise aggregate release notes file
printf "# Release Notes\n" > CHANGELOG.md

# Append individual version release notes to aggregate file
for file in $(ls -rv1 doc/release-notes/*.md); do
    printf "\n## $(basename $file .md)\n\n" >> CHANGELOG.md
    cat $file >> CHANGELOG.md
done

# Add aggregate file to commit
git add CHANGELOG.md
