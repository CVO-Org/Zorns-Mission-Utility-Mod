#include "..\script_component.hpp"

// Server Event
if (isNil QGVAR(EHID_revealObject)) then { GVAR(EHID_revealObject) = [QGVAR(EH_revealObject), FUNC(reveal_object)] call CBA_fnc_addEventHandler; }; // Server Event, Headless or PlayerServer

// Player Events
if (isNil QGVAR(EHID_addAction)) then { GVAR(EHID_addAction) = [QGVAR(EH_addAction), FUNC(add_action)] call CBA_fnc_addEventHandler; }; // this needs to be executed on all clients
if (isNil QGVAR(EHID_playSound)) then { GVAR(EHID_playSound) = [QGVAR(EH_playSound), FUNC(play_sound)] call CBA_fnc_addEventHandler; }; // this needs to be executed on all clientsGVAR()
