# MUM Intel
An Intel Framework

Highly inspired by the Intel Module from Zeus Enhanced, but made to be used in the 3den Editor.

Turns any object into an ACE-interactable intel item. Players gather the intel with an ACE action and a progress bar. Once found, the intel is shared according to its [Share With](#share-with) option: those players get a notification, and the intel is added to the "Intel" section of their map screen.

Requires ACE3 (interaction menu and progress bar) and CBA.


## How it works

- **Gathering**: the intel object gets an ACE action. Completing the progress bar reports the find to the server. The progress bar plays body or keyboard sounds, and is aborted if the player goes down or the intel is shared with them in the meantime.
- **Sharing**: the server stores who the intel has been shared with and sends it only to those players. The action is hidden for every player who already has the intel.
- **Object**: with "Remove Object" enabled, the object is deleted once found. Otherwise it stays, and players without access to the intel can still gather it.
- **Diary**: each piece of intel gets a diary record under "Intel". Intel items with the **same title** are combined into one record, separated by a "NEW INTEL" line.
- **Intel Summary**: a separate "Intel Summary" diary record shows, per intel group, how many items the player has found out of the total (e.g. `2 / 3 - Bomb Makers Hideout`).
- **Zeus**: all curators are informed when intel is found.
- **JIP**: players who join (or rejoin) mid-mission get all intel that has been shared with them, without notifications.


## Share With

| Option    | Shared with                                                                     |
| --------- | ------------------------------------------------------------------------------- |
| `GLOBAL`  | Every player, including players joining the mission later                                |
| `SIDE`    | Every player on the side of the finder, including players joining the mission later on that side |
| `GROUP`   | Every player in the group of the finder, including players joining the mission later in that group |
| `UNIT`    | Only the finder                                                                 |
| `DEFAULT` | Uses the CBA setting "Default ShareWith" (`MUM - Intel` > `General`, default: `SIDE`) |

The finder always receives the intel, whatever the option is.


## Eden Editor Modules

Found under `Modules` > `MUM - Intel Modules`. Place a module and **sync** it to one or more objects; every synced object becomes its own intel item with the module's content.

| Module                         | Content                                                                 |
| ------------------------------ | ----------------------------------------------------------------------- |
| Intel Item - Basic             | Free text / structured text                                             |
| Intel Item - eMail             | Date, sender, recipient, subject and body, formatted as an email        |
| Intel Item - Handwritten Note  | Text in a handwritten font                                              |
| Intel Item - Messages          | Chat history with up to 6 messages, each from the sender or the recipient |
| Intel Item - Photo             | Image (object texture or custom path) with a handwritten note on the back |

All modules share these attributes:
- **Intel Group**: used to group intel items in the Intel Summary, e.g. by location or objective
- **Intel Title**: title of the diary record
- **Intel Description**: short text in grey above the intel content
- **Remove Object**: whether the object is deleted once found (default: off)
- **Action Title**: text of the ACE action and progress bar
- **Action Duration**: duration of the progress bar in seconds (1 second in Eden preview)
- **Action Sound**: `AUTO` (keyboard sounds for laptops, PCs and similar, body sounds otherwise), `BODY` or `KEYBOARD`
- **Share With**: see [Share With](#share-with)

Only sync connections are allowed. ACE intel items and inventory items (weapon holders) cannot be intel objects, and such connections are removed in the editor.

Use `<br/>` for line breaks in text fields.


## API

```sqf
/*
* Author: Zorn
* Function to create an Intel Item. Server only - does nothing on clients.
*
* Arguments:
* 0: _object        <OBJECT>
*           Object which shall be the intel.
*
* 1: _intelTitle    <STRING>
*           The title of the Intel piece.
*
* 2: _intelContent  <STRING>
*           Content of the Intel - Can be very simple String or can be formatted as Structured Text.
*           Needs to be a String, not text.
*
* 3: _intelGroup    <STRING>  <OPTIONAL> <DEFAULT: "General">
*           Group Name of the Intel - Only used for the Intel Summary Feature. Can be, for Example, Location based or Type Based.
*
* 4: _removeObject  <BOOLEAN> <OPTIONAL> <DEFAULT: false>
*           Whether the object gets deleted once it has been picked up or not.
*
* 5: _actionTitle   <STRING>  <OPTIONAL> <DEFAULT: "Gather Intel">
*           String to be used for the Ace Action and Progress Bar.
*
* 6: _actionDuration <NUMBER>  <OPTIONAL> <DEFAULT: 15>
*           Duration of the Progressbar in Seconds. Reduced to 1 second in the Eden Editor preview.
*
* 7: _actionSound   <STRING>  <OPTIONAL> <DEFAULT: "AUTO">
*           Can be "BODY", "KEYBOARD" or "AUTO".
*           "AUTO" will check if Object is like Laptop or similar.
*           Defines the Type of Sound during the Progressbar.
*
* 8: _shareWith     <STRING>  <OPTIONAL> <DEFAULT: "DEFAULT">
*           Can be "GLOBAL", "SIDE", "GROUP", "UNIT", "DEFAULT".
*           "DEFAULT" will reference CBA Setting defined default.
*           Defines who the intel is being shared with once it is picked up. See "Share With" above.
*
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [this, "Secret Documents", "We, the bad guys, will attack the good guys tonight at checkpoint charlie!", "Group", true, "Read Documents"] call MUM_intel_fnc_createIntel;
*/
```

## Example
```sqf
private _structuredString = "
<font size='12' face='EtelkaMonospacePro'>
<br/>Message history:
<br/>From: B. Keller
<br/>To: All Shift Captains</font>
<br/>
<br/>Hey Shift Captains, we at Daltgreen have been pioneers in extraction for decades, leading the field in new and exciting techniques for mining.
<br/>Today, we are rolling out another of our revolutionary innovations in geoengineering, and you will be the first people to use this revolution in the field!
<br/>One word of caution, some of the materials we will be working with will be moderately hazardous, and we recommend that all Daltgreen personnel use appropriate personal protective equipment.
<br/>Your teams will be issued the correct PPE at your next pre-shift meeting.
";

[
    laptop,             // Object
    "Network-Log",      // Intel Title
    _structuredString,  // Intel Content (Structured Text as STRING)
    nil,                // Intel Group, nil for Default Group (Optional, nil for Default Group: "General")
    true,               // Remove Object once Picked up - (Optional - Default: false)
    nil,                // Action Title (Optional - Default: "Gather Intel")
    nil,                // Action Duration (Optional - Default: 15)
    nil,                // Action Sound (Optional - Default: "AUTO")
    "GROUP"             // Share With (Optional - Default: "DEFAULT")
] call MUM_intel_fnc_createIntel;
```

## Structured Text as Strings Examples

### Text Messages
```sqf
private _structuredString = "
<font size='14' face='EtelkaMonospacePro'>
<br/>Messenger App History with 'Boss' - 1 year ago:</font>
<br/>
<br/><font size='12' color='#2dc492' face='EtelkaMonospacePro'>Hey Boss - Bad news - The prisoner died. I think we should have given some water. - Do you want us to wait for the ION guys?</font>
<br/>
<br/><font size='12' color='#2d97fa' face='EtelkaMonospacePro'>Wait until the evening, otherwise just leave.</font>
<br/>
<br/><font size='12' color='#2dc492' face='EtelkaMonospacePro'>We kinda like...got lost on the way here and the GPS ran out of batteries - can you give us the direciton? Jamal has a compass.</font>
<br/>
<br/><font size='12' color='#2d97fa' face='EtelkaMonospacePro'>Seems like you guys outran your own wisdom again... Let me take a look...</font>
<br/>
<br/>
<br/><font size='12' color='#2d97fa' face='EtelkaMonospacePro'>Right... the coordinates we gave you are 1800 meters at bearing 350 from base.</font>
";
```


### Email Message
```sqf
private _structuredString = "
<font size='12' face='EtelkaMonospacePro'>
<br/>Message history:
<br/>From: B. Keller
<br/>To: All Shift Captains</font>
<br/>
<br/>Hey Shift Captains, we at Daltgreen have been pioneers in extraction for decades, leading the field in new and exciting techniques for mining.
<br/>Today, we are rolling out another of our revolutionary innovations in geoengineering, and you will be the first people to use this revolution in the field!
<br/>One word of caution, some of the materials we will be working with will be moderately hazardous, and we recommend that all Daltgreen personnel use appropriate personal protective equipment.
<br/>Your teams will be issued the correct PPE at your next pre-shift meeting.
";
```


### handwritten note with red ink
```sqf
private _structuredString = "
<br/>You found a handwritten note in the ION barracks under a bed:
<br/><font size='24' color='#ff000d' face='shaffilastri'>Take your team and go make sure that village elder cant bother us any more.</font>
";
```


### Images
```sqf
private _structuredString = format ["<img width='370' image='%1'/>", getMissionPath "intel\handdrawnmapws.paa" ];
```


### template
```sqf
private _structuredString = "
<font size='12' face='EtelkaMonospacePro'>
<br/>Message history:
</font>
";
```
