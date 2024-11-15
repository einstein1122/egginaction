#Requires -Version 5.1

[CmdletBinding()]
param (
    # The name of the assembly; must not contain whitespace, and is recommended to be in PascalCase
    [Parameter(Mandatory)]
    [String] $AssemblyName,

    # The user-friendly name for the mod
    [Parameter(Mandatory)]
    [String] $ModName,

    # The user-friendly description for the mod; must only be a single line
    [Parameter(Mandatory)]
    [String] $ModDescription
)

# Ensure we're in the root of the repository
Set-Location -Path "$(git.exe rev-parse --show-toplevel)"

# Update project file
$CSProject = Get-Content -Path '##__ASSEMBLY_NAME__##.csproj' -Raw
$CSProject = $CSProject -Replace '##__ASSEMBLY_NAME__##', "$AssemblyName"
$CSProject = $CSProject -Replace '##__MOD_NAME__##', "$ModName"
$CSProject = $CSProject -Replace '##__MOD_DESCRIPTION__##', "$ModDescription"
Set-Content -Path "$AssemblyName.csproj" -Value "$CSProject" -NoNewline
Remove-Item '##__ASSEMBLY_NAME__##.csproj'

# Update plugin code
$Code = Get-Content -Path 'src\##__ASSEMBLY_NAME__##.cs' -Raw
$Code = $Code -Replace '##__ASSEMBLY_NAME__##', "$AssemblyName"
Set-Content -Path "src\$AssemblyName.cs" -Value "$Code" -NoNewline
Remove-Item 'src\##__ASSEMBLY_NAME__##.cs'

# Update CI config
$CI = Get-Content -Path 'disabled.gitlab-ci.yml' -Raw
$CI = $CI -Replace '##__ASSEMBLY_NAME__##', "$AssemblyName"
Set-Content -Path '.gitlab-ci.yml' -Value "$CI" -NoNewline
Remove-Item 'disabled.gitlab-ci.yml'

# Update readme
$Readme = Get-Content -Path 'README.md' -Raw
$Readme = $Readme -Replace '##__ASSEMBLY_NAME__##', "$AssemblyName"
$Readme = $Readme -Replace '##__MOD_NAME__##', "$ModName"
$Readme = $Readme -Replace '##__MOD_DESCRIPTION__##', "$ModDescription"
Set-Content -Path 'README.md' -Value "$Readme" -NoNewline

# Update license
$Copyright = Get-Content -Path 'LICENSE' -Raw
$Copyright = $Copyright -Replace '##__YEAR__##', (Get-Date -Format yyyy)
Set-Content -Path 'LICENSE' -Value "$Copyright" -NoNewline
