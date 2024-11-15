# 🎨 Coloured Stages

Colours each tile a distinctive colour based on the stage it was generated in.

[![latest version](https://img.shields.io/gitlab/v/tag/isekai%252Fmodding%252Frogue-tower/ColouredStages?label=Latest&sort=semver&style=for-the-badge)](https://gitlab.com/isekai/modding/rogue_tower/ColouredStages/-/releases)
[![pipeline status](https://img.shields.io/gitlab/pipeline/isekai/modding/rogue-tower/ColouredStages/main?style=for-the-badge)](https://gitlab.com/isekai/modding/rogue-tower/ColouredStages/-/pipelines/main/latest)
[![lines of code](https://img.shields.io/tokei/lines/gitlab/isekai%252Fmodding%252Frogue-tower/ColouredStages?style=for-the-badge)](https://gitlab.com/isekai/modding/rogue-tower/ColouredStages)

## Installation instructions

1. Download and install Rogue Tower from your distributor of choice
2. Download and install the latest stable 32-bit (not 64-bit) release
   of [BepInEx 5](https://docs.bepinex.dev/articles/user_guide/installation/index.html)
   into your Rogue Tower installation directory
3. Download the latest release
   of [ColouredStages](https://gitlab.com/isekai/modding/rogue-tower/ColouredStages/-/releases)
4. Extract the contents of the archive into your Rogue Tower installation directory
5. (Optional) Download and install the latest release
   of [Configuration Manager](https://github.com/BepInEx/BepInEx.ConfigurationManager)
   into your Rogue Tower installation directory
    - Access settings with F1 (by default); allows you to disable the mod without uninstalling it entirely

## Release notes

Release notes can be found in [CHANGELOG.md](./CHANGELOG.md).

## Build instructions

1. Download and install Rogue Tower from your distributor of choice
2. Download and install the latest stable 32-bit (not 64-bit) release
   of [BepInEx 5](https://docs.bepinex.dev/articles/user_guide/installation/index.html)
   into your Rogue Tower installation directory
3. Download and install the latest version of the [.NET SDK](https://dotnet.microsoft.com/en-us/download)
    - For Arch Linux, the [`dotnet-sdk-bin` AUR package](https://aur.archlinux.org/packages/dotnet-sdk-bin/) can be used
4. Set the `ROGUE_TOWER_HOME` environment variable to your Rogue Tower installation directory
    - Should contain the main game executable inside (`Rogue Tower.exe`)
    - For Linux, add the following `export` line to `~/.profile` (creating the file if it doesn't exist):
       ```sh
       export ROGUE_TOWER_HOME="<<path-to-game-installation-directory>>"
       ```
5. Open the solution in your IDE of choice, or restart it if it was already running so the new environment variable is
   picked up
    - Note that in the case of JetBrains Rider, `File -> Invalidate Caches... -> Just restart` is not sufficient
    - On Linux, you may need to logout and re-login to your desktop session
6. Build the solution using your IDE

### Build tasks

#### Pre-build

- Copies the necessary assemblies from the game directory

#### Post-build

- Copies the compiled `.dll` to the game directory, reading for testing

## Developing

1. Setup your environment as per the build instructions above
2. Download and install the latest release of the following plugins:
    - [Configuration Manager](https://github.com/BepInEx/BepInEx.ConfigurationManager)
    - [Demystify Exceptions](https://github.com/BepInEx/BepInEx.Debug)
    - [Runtime Unity Editor](https://github.com/ManlyMarco/RuntimeUnityEditor)
    - [Script Engine](https://github.com/BepInEx/BepInEx.Debug)
3. Run the following (from the root of the repository) to enable git hooks:
    - macOS / Linux:
       ```sh
       chmod u+x scripts/git/setup-hooks.sh
       ./scripts/git/setup-hooks.sh
       ```
    - Windows (future updates will not auto-apply; run again to apply them manually):
       ```powershell
       ./scripts/git/setup-hooks.ps1
       ```
4. To enable hot-loading the mod during runtime (utilising Script Engine), comment out the two lines under
   the `BepInEx Plugin` comment in `ColouredStages.csproj`, and uncomment the two lines under `Hot-loadable Script`.

### Git hooks

#### Pre-commit

- Aggregate individual release notes files (under `doc/release-notes`) into a combined file at `CHANGELOG.md`

### Initialising new project from template

1. Run the following (from the root of the repository) to initialise a new project from the template
    - macOS / Linux:
       ```sh
       chmod u+x scripts/init.sh
       ./scripts/init.sh
       ```
    - Windows (future updates will not auto-apply; run again to apply them manually):
       ```powershell
       ./scripts/init.ps1
       ```
