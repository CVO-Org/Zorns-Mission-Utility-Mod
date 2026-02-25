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
] call mum_intel_fnc_createIntel;

[
    laptop_1,
    "E-Mails",
    _structuredString,
    nil,
    false
] call mum_intel_fnc_createIntel;

[
    laptop_2,
    "E-Mails",
    _structuredString,
    nil,
    true
] call mum_intel_fnc_createIntel;

[
    laptop_3,
    "Network-Log",
    _structuredString,
    "Test Group",
    false
] call mum_intel_fnc_createIntel;

[
    laptop_4,
    "E-Mails",
    _structuredString,
    "Test Group"
] call mum_intel_fnc_createIntel;

[
    laptop_5,
    "Network-Log",
    _structuredString,
    "Test Group",
    false
] call mum_intel_fnc_createIntel;
