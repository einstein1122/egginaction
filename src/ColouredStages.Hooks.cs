using System.Diagnostics.CodeAnalysis;
using HarmonyLib;
using UnityEngine;

namespace Dev.Isekai.RogueTower.ColouredStages;

public partial class ColouredStages
{
    [SuppressMessage(
        "ReSharper",
        "InconsistentNaming",
        Justification = "Harmony uses magic parameter names for hooking into the game's functions"
    )]
    private static class Hooks
    {
        [HarmonyPatch(typeof(GameManager), "Awake")]
        [HarmonyPostfix]
        private static void OnStartGame(TerrainTile ___singleStartTile)
        {
            SetTileColour(___singleStartTile, Config.Goblin);
            Logger.LogDebug($"Updating start tile's colour to: {Config.Goblin.ToString()}");
        }

        [HarmonyPatch(typeof(TerrainTile), nameof(TerrainTile.ConnectToTile))]
        [HarmonyPostfix]
        private static void OnConnectToTile(TerrainTile __instance)
        {
            var colour = SpawnManager.instance.level switch
            {
                < 15 => Config.Goblin,
                < 25 => Config.Zombie,
                < 29 => Config.Demon,
                < 35 => Config.Robot,
                _ => Config.Eldritch
            };

            Logger.LogDebug($"Updating new tile's colour to: {colour.ToString()}");
            SetTileColour(__instance, colour);
        }

        private static void SetTileColour(TerrainTile tile, Color colour)
        {
            foreach (Transform child in tile.gameObject.transform)
            {
                if (child.name == "Terrain")
                {
                    child.GetComponent<MeshRenderer>().material.color = colour;
                }
            }
        }
    }
}
