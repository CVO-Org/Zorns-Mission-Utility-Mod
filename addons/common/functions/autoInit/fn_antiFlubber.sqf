#include "..\..\script_component.hpp"

/*
* Author: Someone - reworked by Zorn
*
*    Enables AntiFlubber Script
*    Checks (missionConfigFile >> "enableAntiFlubber") == 1 to enable it.
*    Attention: Scheduled Code!
*
*/

// Run on all clients with an interface. Not the server(if dedicated) and not on headless clients.

if (getNumber (missionConfigFile >> "enableAntiFlubber") != 1) exitWith {};

INFO("AntiFlubber enabled!");

if (hasInterface) then {

    waitUntil {!isNull player && isPlayer player};
    if (isNil "DM_Debug") then {DM_Debug = false;};
    if (DM_Debug) then {(format["%1 has joined and is running antiFlubber.sqf", (name player)]) remoteExec ["systemChat", -2];};

    player addEventHandler ["Fired",
    {


        comment "Check if the description / tooltip of the grenade magazine has the word 'smoke' in it. as far as I can tell all the smoke grenades we have fulfil this criteria";
        if !(["smoke", (getText (configFile >> "CfgMagazines" >> (_this select 5) >> "descriptionShort"))] call BIS_fnc_inString) exitWith {if (DM_Debug) then {systemChat "antiFlubber - You fired a non 'smoke' weapon.";};};
        comment "Fired event handler goes off even when you throw something. Check if we are throwing something or the hand smoke will hit an invisible 0.5m wall whenever you throw it.";
        if ((_this select 1) == "throw") exitWith {if (DM_Debug) then {systemChat "antiFlubber - You Threw a Smoke Grenade.";};};
         comment "CharlieG smoke rounds set the script off, do a quick check to see if we are firing the smoke rocket. The russian fast smoke grenade does not need to be stopped.";
        if ((_this select 5) in ["tb_mk13_smoke","rhs_GDM40"]) exitWith {if (DM_Debug) then {systemChat "antiFlubber - You Fired a Blacklisted Smoke Round.";};};
        _this spawn
        {
            if (DM_Debug) then {systemChat "antiFlubber - Smoke Round Detected";};
            _GL = _this;
            _runTime = time;
            _landed = false;

            comment "keep checking the projectile until either 20 seconds have passed since the round was fired or the round has landed.";
            while {((_runTime + 20) > time) && !_landed} do
            {
                comment "Wait 0.5 seconds after firing to make sure that if the grenade is fired while prone the round will not get stuck to the floor as soon as it leaves the barrel.";
                if (time < (_runTime + 0.5)) then {} else
                {
                    comment "Wait until the round is less that 0.5m away from the floor. Then setVelocity to 0 in all directions to stop the round from moving. Gravity then pulls the round to the floor.";
                    if (((getPosATL (_GL select 6)) select 2) < 0.5) then
                    {
                        (_GL select 6) setVelocity [0,0,0];
                        _landed = true;
                    };
                };
                comment "Sleep to give our little cpu's a short break.";
                sleep 0.1;
            };
            if (DM_Debug) then { if (_landed) then {systemChat "antiFlubber - Smoke Round Stopped - Script Ended";} else { systemChat "antiFlubber - Smoke Round Timed out - Script Ended."; };};
        };
    }];

};
