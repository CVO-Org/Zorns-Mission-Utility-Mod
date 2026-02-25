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

private _allRecords = player allDiaryRecords QGVAR(intel);
private _index = _allRecords findIf { _x select 1 isEqualTo _intelTitle };

if (_index == -1) then {
    // Create New
    player createDiaryRecord [QGVAR(intel), [_intelTitle, _intelContent]];

} else {
    // Attach to existing
    private _existingRecord =  _allRecords select _index select 8;
    private _existingContent = _allRecords select _index select 2;

    private _newIntelContent = [_existingContent, "", "####################################################","",_intelContent] joinString "<br />";

    player setDiaryRecordText [[QGVAR(intel), _existingRecord], [_intelTitle, _newIntelContent]];

};

