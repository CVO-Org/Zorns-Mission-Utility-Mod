# MUM Intel
An Intel Framework


```sqf

/*
* Author: Zorn
* Function to create an Intel Item.
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
* 4: _removeObject  <BOOLEAN> <OPTIONAL> <DEFAULT: true>
*           Weather the Object gets deleted once it has been picked up or not.
*
* 5: _actonTitle    <STRING>  <OPTIONAL> <DEFAULT: "Gather Intel">
*           String to be used for the Ace Action and Progress Bar.
*
* 6: _actonDuration <NUMBER>  <OPTIONAL> <DEFAULT: 15>
*           Duration of the Progressbar in Seconds. Will be reducing in Eden Editor Preview Editor to 1 second.
*
* 7: _actionSound   <STRING>  <OPTIONAL> <DEFAULT: "AUTO">
*           Can be "BODY", "KEYBOARD" or "AUTO".
*           "AUTO" will check if Object is like Laptop or similar.
*           Defines the Type of Sound during the Progressbar.
*
* 8: _shareWith     <STRING>  <OPTIONAL> <DEFAULT: "DEFAULT">
*           Can be "GLOBAL", "SIDE", "GROUP", "UNIT", "DEFAULT".
*           "DEFAULT" will reference CBA Setting defined default.
*           Defines who the intel is being shared with once its picked up.
*
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [this, "Secret Documents", "We, the bad guys, will attack the good guys tonight at checkpoint charlie!", "Group", true, _actionTitle] call MUM_intel_fnc_createIntel;

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
    false               // Remove Object once Picked up - (Optional - Default: true)
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
