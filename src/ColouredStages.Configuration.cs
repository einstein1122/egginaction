using System;
using System.Diagnostics.CodeAnalysis;
using BepInEx.Configuration;
using UnityEngine;

namespace Dev.Isekai.RogueTower.ColouredStages;

public partial class ColouredStages
{
    [SuppressMessage(
        "ReSharper",
        "UnusedMember.Local",
        Justification = "Convenience accessors for configuration available for use in future versions"
    )]
    [SuppressMessage(
        "ReSharper",
        "MemberCanBePrivate.Local",
        Justification = "Convenience accessors for configuration available for use in future versions"
    )]
    private class Configuration
    {
        private readonly ConfigEntry<bool> _enabled;

        private readonly ConfigEntry<Color> _goblin;
        private readonly ConfigEntry<Color> _zombie;
        private readonly ConfigEntry<Color> _demon;
        private readonly ConfigEntry<Color> _robot;
        private readonly ConfigEntry<Color> _eldritch;

        internal bool Enabled => _enabled.Value;

        internal Color Goblin => _goblin.Value;
        internal Color Zombie => _zombie.Value;
        internal Color Demon => _demon.Value;
        internal Color Robot => _robot.Value;
        internal Color Eldritch => _eldritch.Value;

        internal Configuration(ConfigFile config)
        {
            _enabled = config.Bind("General", "Enabled", true, "Is the mod enabled?");
            _enabled.SettingChanged += OnEnabledChanged;

            _goblin = config.Bind("Colours", "(1) Goblin", new Color(0, 0.5F, 0.1F, 1), "Goblin stage colour");
            _zombie = config.Bind("Colours", "(2) Zombie", new Color(0.2F, 0.5F, 0.4F, 1), "Zombie stage colour");
            _demon = config.Bind("Colours", "(3) Demon", new Color(0.3F, 0, 0, 1), "Demon stage colour");
            _robot = config.Bind("Colours", "(4) Robot", new Color(0.6F, 0.7F, 0.5F, 1), "Robot stage colour");
            _eldritch = config.Bind("Colours", "(5) Eldritch", new Color(0.3F, 0, 0.5F, 1), "Eldritch stage colour");
        }

        private void OnEnabledChanged(object sender, EventArgs args)
        {
            if (Enabled)
            {
                Patch();
            }
            else
            {
                Unpatch();
            }
        }
    }
}
