# mum_common_fnc_cutscene

This function allows you to easily create human-readable cutscene timelines in Arma 3, without worrying about the underlying implementation details.

**Note:** This function should be executed on individual clients. Server-only code execution should be handled separately.


## Usage

Call the function with an array of timeline entries.
Each entry is an array: `[type, arguments...]`.

**Example:**

```sqf
[
	["JIP", true],
    ["QUIET", 6],
	["DELAY", 2],
	["MUTE"],
	["START", 6], // Fade to black for 6 seconds
	["MUSIC_BOOST"],
	["DELAY", 2],
	["MUSIC", "EventTrack01_F_EPA"],
	["DELAY", 2],
	["TEXT", "In 1974, the colonial government of Bocano collapsed with the fall of the Estado Novo."],
    ["CODE", { systemChat format ["Player did JIP: %1", _isJIP]; } ],
	["TEXT", "Good Luck....."],
	["DELAY", 2],
	["RAVEN", 6], // Show Raven image for 6 seconds
	["DELAY", 2],
	["UNMUTE", 10],
	["END", 6] // Fade from black for 6 seconds
] call mum_common_fnc_cutscene;
```

---

## Timeline Entry Types

| Type          | Description                 | Arguments                                   | Adds Duration to Delay | Example Usage                             | Additionals                             |
| ------------- | --------------------------- | ------------------------------------------- | :--------------------: | ----------------------------------------- | --------------------------------------- |
| `START`       | Fade screen to black        | Duration (number, seconds)                  |          Yes           | `["START", 6]`                            | disables map, hide DUI                  |
| `END`         | Fade screen from black      | Duration (number, seconds)                  |           No           | `["END", 6]`                              | enable map, delayed unhide DUI          |
| `TEXT`        | Text overlay on background  | String/Array of strings, Duration (seconds) |          Yes           | `["TEXT", "Hello", 7]`                    |                                         |
| `TEXT_PLAIN`  | Text overlay, no background | String/Array of strings, Duration (seconds) |          Yes           | `["TEXT_PLAIN", ["Line 1", "Line 2"], 7]` |                                         |
| `BLUR_IN`     | Fade in blur effect         | Duration (number, seconds)                  |           No           | `["BLUR_IN", 3]`                          |                                         |
| `BLUR_OUT`    | Fade out blur effect        | Duration (number, seconds)                  |           No           | `["BLUR_OUT", 3]`                         |                                         |
| `DELAY`       | Add delay only              | Duration (number, seconds)                  |          Yes           | `["DELAY", 5]`                            |                                         |
| `CODE`        | Execute code                | Code block, optional params                 |           No           | `["CODE", { hint "Hello"; }]`             |                                         |
| `RAVEN`       | Show Raven image            | Duration (number, seconds)                  |           No           | `["RAVEN", 6]`                            | White Raven, no Text                    |
| `QUIET`       | Show quiet-please image     | Duration (number, seconds)                  |           No           | `["QUIET", 6]`                            | Icon with Finger infront of lips        |
| `MUTE`        | Mutes sounds                | Duration (number, seconds)                  |           No           | `["MUTE_IN", 6]`                          | handles radio, sound, environemnt, acre |
| `UNMUTE`      | Reverts sounds              | Duration (number, seconds)                  |           No           | `["MUTE_OUT", 6]`                         | handles radio, sound, environemnt, acre |
| `MUSIC`       | Plays Music                 | CfgMusic Classname (string)                 |           No           | `["MUSIC", "mySong"]`                     |                                         |
| `MUSIC_BOOST` | Aplifies Music Volume       | Duration (number, seconds)                  |           No           | `["MUSIC_IN", 6]`                         | handles radio, sound, environemnt, acre |
| `MUSIC_RESET` | Reverts Music Volume        | Duration (number, seconds)                  |           No           | `["MUSIC_OUT", 6]`                        | handles radio, sound, environemnt, acre |
| `JIP`         | Controls _isJIP             | Boolean                                     |           No           | `["JIP", true]`                           | handles radio, sound, environemnt, acre |

**Notes:**
- For `TEXT` and `TEXT_PLAIN`, you can pass a single string or an array of strings.
- For `CODE`, you may optionally pass parameters as the second argument.
- For `CODE`, the magic variable `_isJIP` will be available, based on the presence of `JIP` and/or its param
---

## Customization

You can override the following global variables via `missionNamespace setVariable` to change cutscene appearance:

| Variable Name                        | Default Value    | Description                          |
|-------------------------------------- |-----------------|--------------------------------------|
| `mum_common_cutscene_defaultDelay`    | `7`             | Default duration and delay (seconds) |
| `mum_common_cutscene_defaultSize`     | `3`             | Default font size for text           |
| `mum_common_cutscene_defaultColor`    | `"#690000"`     | Default font color for text          |
| `mum_common_cutscene_defaultFont`     | `"EraserRegular"`| Default font for text                |

**Example:**
```sqf
missionNamespace setVariable ["mum_common_cutscene_defaultDelay", 10];
missionNamespace setVariable ["mum_common_cutscene_defaultFont", "PuristaMedium"];
```

---

## Tips

- Always execute on clients, not the server.
- Use `CODE` entries for custom logic (e.g., disabling controls).
- Combine types for more complex cutscenes.


