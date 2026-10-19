#include "../../script_component.hpp"

/*
* Author: Zorn
* Creates the "Intel" diary subject for the local player if it does not exist yet.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* call mum_intel_fnc_createIntelSubject
*
* Public: No
*/

if !(player diarySubjectExists QGVAR(subject)) then { player createDiarySubject [QGVAR(subject), "Intel"]; };
