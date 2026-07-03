[
    "AAF"                                       // Faction Name (Title)
    ,"
<br/>In the wake of civil war, the Jerusalem Cease Fire of 2030 mandated the creation of an armed defence force to secure the sovereign territory of The Republic of Altis and Stratis.
<br/>
<br/>Although it officially operates under the observation and training of international peacekeepers, the force remains loyal to the new, hard-line Altis government and acts with de facto judicial and executive authority. However, it is debilitated by an inexperienced command structure and is blighted by widespread corruption.
"                                               // Description Text
    ,"Colloquially known as Greenbags"          // subTitle
    ,getMissionPath "aaf_photo_1024.paa"             // Photo
    ,"\a3\Data_f\Flags\flag_AAF_co.paa"       // Flag
] call mum_diary_fnc_setAlliedForces;


///////////////



[
	"Additional"		// Subject Display Name
	,"CommsPlan"		// Record Display Name
	,""				 // Image inside the Entry. Example: getMissionPath "\data\personalities.paa"
	,""				 // Subtitles
	,"
<br/> 343 Squad Radios
<br/> Block 1 Channel 1: 1-1 - Infantry
<br/> Block 1 Channel 2: 1-2 - Infantry
<br/> Block 1 Channel 6: 1-6 - Platoon Element
<br/>
<br/> 152 Radios
<br/> Channel 1: Platoon Net
<br/> Channel 2: AIR Net
"					   // Text Body
	// ,_icon		   // Image next to the entry Title (small flags for example)
	// ,_newName
	// ,_target
] call mum_diary_fnc_setEntry;
