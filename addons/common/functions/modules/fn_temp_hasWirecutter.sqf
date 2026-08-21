#include "..\..\script_component.hpp"

/*
 * Author: PabstMirror, OverlordZorn
 * Function to theck if the provided Unit has a wirecutter.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * hasWirecutter <BOOL>
 *
 * Example:
 * [cursorObject] call ace_logistics_wirecutter_fnc_hasWirecutter
 *
 * Public: yes
 */

params ["_unit"];

((_unit call ace_common_fnc_uniqueItems) arrayIntersect ace_logistics_wirecutter_possibleWirecutters) isNotEqualTo []
|| {getNumber ((configOf (backpackContainer _unit)) >> "ace_logistics_wirecutter_hasWirecutter") == 1}
|| {getNumber (configFile >> "CfgWeapons" >> (vest _unit) >> "ace_logistics_wirecutter_hasWirecutter") == 1}
