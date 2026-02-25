#include "../../script_component.hpp"

/*
* Author: Zorn
* 
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

if !(player diarySubjectExists QGVAR(intel)) then { player createDiarySubject [QGVAR(intel), "Intel"]; };
