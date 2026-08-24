#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module Function to turn an object into a an MUM Intel item.
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

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith {};

// Get Data
private _intelGroup =           _logic getVariable [QGVAR(intelGroup), "General"];
private _intelTitle =           _logic getVariable [QGVAR(intelTitle), "A piece of Intel"];

// Email Data
private _emailSender =      _logic getVariable [QGVAR(emailSender), "Sender"];
private _emailRecipient =   _logic getVariable [QGVAR(emailRecipient), "Recipient"];
private _emailDate =        _logic getVariable [QGVAR(emailDate), ""];
private _emailSubject =     _logic getVariable [QGVAR(emailSubject), "Subject"];
private _emailText =        _logic getVariable [QGVAR(emailText), "Dear sir or madam, <\br> we are trying to reach you regarding your cars extended warrenty."];

// Intel Meta
private _removeObject =     _logic getVariable [QGVAR(removeObject), true];
private _actionTitle =      _logic getVariable [QGVAR(actionTitle), "Gathering Intel..."];
private _actionDuration =   _logic getVariable [QGVAR(actionDuration), 15];
private _actionSound =      _logic getVariable [QGVAR(actionSound), "AUTO"];
private _shareWith =        _logic getVariable [QGVAR(shareWith), "DEFAULT"];


// Compose Intel Body
#define COLOR_EMAIL_HEADER_TITLE   color=QQ(#42d3a3)
#define COLOR_EMAIL_HEADER_CONTENT color=QQ(#429ed3)

private _intelContent = "<br/>";
if (_emailDate      isNotEqualTo "") then {_intelContent = _intelContent + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>DATE: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailDate]; };
if (_emailSender    isNotEqualTo "") then {_intelContent = _intelContent + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>FROM: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailSender]; };
if (_emailRecipient isNotEqualTo "") then {_intelContent = _intelContent + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>  TO: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailRecipient]; };
if (_emailSubject   isNotEqualTo "") then {_intelContent = _intelContent + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>SUBJ: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailSubject]; };
if (_emailText      isNotEqualTo "") then {_intelContent = _intelContent + format [Q(<br/><font face='EtelkaMonospaceProBold' size='11'>%1</font>), _emailText]; };


// Handle Intel
{ [_x, _intelTitle, _intelContent, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel) } forEach _units;

nil
