#!/bin/sh

$assembly_name=$1
$mod_name=$2
$mod_description=$3

if [ -z $assembly_name ]; then
    echo "Enter the name of the assembly; must not contain whitespace, and is recommended to be in PascalCase"
    read assembly_name
fi

if [ -z $mod_name ]; then
    echo "Enter the user-friendly name for the mod"
    read mod_name
fi

if [ -z $mod_description ]; then
    echo "Enter the user-friendly description for the mod; must only be a single line"
    read mod_description
fi

# Ensure we're in the root of the repository
cd "$(git rev-parse --show-toplevel)"

# Update project file
sed -ie "s|##__ASSEMBLY_NAME__##|$assembly_name|" '##__ASSEMBLY_NAME__##.csproj'
sed -ie "s|##__MOD_NAME__##|$mod_name|" '##__ASSEMBLY_NAME__##.csproj'
sed -ie "s|##__MOD_DESCRIPTION__##|$mod_Description|" '##__ASSEMBLY_NAME__##.csproj'
mv '##__ASSEMBLY_NAME__##.csproj' "$assembly_name.csproj"

# Update plugin code
sed -ie "s|##__ASSEMBLY_NAME__##|$assembly_name|" 'src/##__ASSEMBLY_NAME__##.cs'
mv '##__ASSEMBLY_NAME__##.cs' "$assembly_name.cs"

# Update CI config
sed -ie "s|##__ASSEMBLY_NAME__##|$assembly_name|" 'disabled.gitlab-ci.yml'
mv 'disabled.gitlab-ci.yml' '.gitlab-ci.yml'

# Update readme
sed -ie "s|##__ASSEMBLY_NAME__##|$assembly_name|" 'README.md'
sed -ie "s|##__MOD_NAME__##|$mod_name|" 'README.md'
sed -ie "s|##__MOD_DESCRIPTION__##|$mod_description|" 'README.md'

# Update license
sed -ie "s|##__YEAR__##|$(date +'%Y')|" 'LICENSE'
