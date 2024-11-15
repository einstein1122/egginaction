using System.Diagnostics.CodeAnalysis;
using BepInEx;
using BepInEx.Logging;
using HarmonyLib;

namespace Dev.Isekai.RogueTower.ColouredStages;

[BepInPlugin(PluginInfo.PLUGIN_GUID, PluginInfo.PLUGIN_NAME, PluginInfo.PLUGIN_VERSION)]
[BepInProcess(EXE_WINDOWS)]
public partial class ColouredStages : BaseUnityPlugin
{
    private const string EXE_WINDOWS = "RogueTower.exe";

    [SuppressMessage("ReSharper", "InconsistentNaming", Justification = "Shadows the non-static base field")]
    private new static ManualLogSource Logger = null!;

    [SuppressMessage("ReSharper", "InconsistentNaming", Justification = "Shadows the non-static base field")]
    [SuppressMessage("ReSharper", "NotAccessedField.Local", Justification = "Available for use in future versions")]
    private new static Configuration Config = null!;

    private static Harmony? _hooks;

    private void Awake()
    {
        Logger = base.Logger;
        Config = new(base.Config);

        Patch();

        Logger.LogInfo("Finished loading.");
    }

    private void OnDestroy()
    {
        Unpatch();
    }

    private static void Patch()
    {
        _hooks = Harmony.CreateAndPatchAll(typeof(Hooks));
    }

    private static void Unpatch()
    {
        _hooks?.UnpatchSelf();
    }
}
