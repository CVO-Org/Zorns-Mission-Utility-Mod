#include "../../script_component.hpp"

/*
* Author: Zorn
* function to actually create  the intel entry.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params ["_id"];

call FUNC(createIntelSubject);


private _intelData = missionNamespace getVariable _id;
private _intelTitle = _intelData getVariable "intelTitle";
private _intelContent = _intelData getVariable "intelContent";

private _allRecords = player allDiaryRecords QGVAR(subject);
private _index = _allRecords findIf { _x select 1 isEqualTo _intelTitle };

if (_index == -1) then {
    // Create New
    player createDiaryRecord [QGVAR(subject), [_intelTitle, _intelContent], taskNull, "", false];

} else {

    // Attach to existing
    private _existingRecord =  _allRecords select _index select 8;
    private _existingContent = _allRecords select _index select 2;

    private _seperator = [" NEW INTEL ", 45, "CENTER", "#"] call EFUNC(common,stringPadding);
    _seperator = [_seperator, 55, "CENTER", " "] call EFUNC(common,stringPadding);
    _seperator = format [Q(<font face='EtelkaMonospaceProBold' COLOR_GREY size='12'>%1</font>),_seperator];

    private _newIntelContent = [_existingContent, "", _seperator, _intelContent] joinString "<br />";

    player setDiaryRecordText [[QGVAR(subject), _existingRecord], [_intelTitle, _newIntelContent]];

};

// Get RecordIndex of new Intel Item
_allRecords = player allDiaryRecords QGVAR(subject);
private _recordIndex = _allRecords select (_allRecords findIf { _x select 1 isEqualTo _intelTitle }) select 0;
// open Intel Subject on map
player selectDiarySubject format ["%1:Record%2", QGVAR(subject), _recordIndex];
