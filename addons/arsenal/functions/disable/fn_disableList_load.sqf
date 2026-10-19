#include "../../script_component.hpp"

/*
* Author: Zorn
* 3DEN attribute load for the "Disable Defaults" module lists.
* Fills the list with one checkbox per default entry. Checked = enabled.
*
* Arguments:
* 0: Attribute controls group <CONTROL>
* 1: Attribute value - disabled entries as stringified array <STRING>
* 2: Kind - "kits", "autoRoles" or "autoTraits" <STRING>
*
* Return Value:
* None
*
* Example:
* [ _ctrlGroup, "[]", "kits" ] call mum_arsenal_fnc_disableList_load
*
* Public: No
*/

params [
    [ "_ctrlGroup", controlNull, [controlNull] ],
    [ "_value",     "[]",        [""]          ],
    [ "_kind",      "",          [""]          ]
];

private _display = ctrlParent _ctrlGroup;
private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_DISABLELIST_LIST;

private _disabled = if ( _value isEqualTo "" ) then { [] } else { parseSimpleArray _value };
private _disabledLower = _disabled apply { toLowerANSI _x };

private _names = [ _kind ] call FUNC(getDefaults);
private _namesLower = _names apply { toLowerANSI _x };

// Keep disabled entries which are not available right now (e.g. from an addon not loaded in the editor), so saving does not drop them.
_ctrlGroup setVariable [ QGVAR(unknown), _disabled select { !( toLowerANSI _x in _namesLower ) } ];

private _rowH = ATTR_ROW_H * ATTR_GRID_H;
private _labelW = ( ATTR_CONTENT_W - ATTR_ROW_H - ATTR_SCROLLBAR_W ) * ATTR_GRID_W;

private _checkboxes = [];
{
    private _name = _x;
    private _y = _forEachIndex * _rowH;

    // Tooltip
    private _tooltip = [ _name ];
    if ( _kind == "kits" ) then {
        private _cfg = configFile >> QGVAR(kits) >> _name;
        private _role = getText ( _cfg >> "role" );
        private _dependency = getText ( _cfg >> "addon_dependency" );
        if ( _role isNotEqualTo "" ) then { _tooltip pushBack format [ "%1: %2", LLSTRING(disableList_role), _role ]; };
        if ( _dependency isNotEqualTo "" ) then { _tooltip pushBack format [ "%1: %2", LLSTRING(disableList_dependency), _dependency ]; };

        // Items - display name, classname when not loaded or without display name
        private _items = "true" configClasses ( _cfg >> "items" ) apply {
            private _class = configName _x;
            private _displayName = getText ( _class call CBA_fnc_getItemConfig >> "displayName" );
            [ _displayName, _class ] select ( _displayName isEqualTo "" )
        };
        if ( _items isNotEqualTo [] ) then {
            _tooltip pushBack "";
            _tooltip append ( _items apply { "- " + _x } );
        };
        if ( getText ( _cfg >> "code" ) isNotEqualTo "" ) then { _tooltip pushBack LLSTRING(disableList_code); };
    };
    _tooltip = _tooltip joinString endl;

    private _ctrlCheckbox = _display ctrlCreate [ "ctrlCheckbox", -1, _ctrlList ];
    _ctrlCheckbox ctrlSetPosition [ 0, _y, ATTR_ROW_H * ATTR_GRID_W, _rowH ];
    _ctrlCheckbox ctrlCommit 0;
    _ctrlCheckbox cbSetChecked !( toLowerANSI _name in _disabledLower );
    _ctrlCheckbox ctrlSetTooltip _tooltip;
    _ctrlCheckbox setVariable [ QGVAR(name), _name ];

    private _ctrlLabel = _display ctrlCreate [ "ctrlStatic", -1, _ctrlList ];
    _ctrlLabel ctrlSetPosition [ ATTR_ROW_H * ATTR_GRID_W, _y, _labelW, _rowH ];
    _ctrlLabel ctrlCommit 0;
    _ctrlLabel ctrlSetText _name;
    _ctrlLabel ctrlSetTooltip _tooltip;

    _checkboxes pushBack _ctrlCheckbox;
} forEach _names;

_ctrlGroup setVariable [ QGVAR(checkboxes), _checkboxes ];

nil
