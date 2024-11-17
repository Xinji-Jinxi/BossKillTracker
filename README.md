# Boss Kill Tracker

# Overview
The Boss Kill Tracker addon allows players to track the number of times they’ve killed specific dungeon and raid bosses in World of Warcraft. It supports all classic and Turtle WoW bosses, maintaining records across gaming sessions.

# Features
- Tracks kill counts for bosses in dungeons, raids, and custom content.
- Logs each boss kill in the chat with the total kill count.
- Allows players to query the kill count of any tracked boss using in-game commands.

# In-Game Commands

Kill Count Query
* /tbk <Boss Name>
* /TotalBossKill <Boss Name>

# Description:
Displays the total number of times the specified boss has been killed.

# Examples:
'/tbk Ragnaros'<br>
Output: Ragnaros: 5 kills.

'/tbk InvalidBossName'<br>
Output: InvalidBossName is not a recognized boss name.

# Notes
If no input is provided or the boss name is unrecognized, an error message will be displayed.
All tracked bosses are predefined and include all major dungeon, raid, and custom bosses.

# Installation
- Extract the addon to your WoW Interface/AddOns/ directory.
- Enable the addon in the game’s AddOns menu.
- Reload your UI or restart the game to begin tracking!
