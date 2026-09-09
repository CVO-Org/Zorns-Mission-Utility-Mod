
class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_TeamManagement {
                class GVAR(becomeTeamleader) {
                    displayName = CSTRING(stepUpTeamleader);
                    condition = QUOTE(leader _player isNotEqualTo _player && {_player getVariable [ARR_2(QQGVAR(isTeamLeader),false)] isEqualTo false});
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};
                    statement = QUOTE(_player call FUNC(TeamLeaderStepUp));
                };
                class GVAR(unbecomeTeamleader) {
                    displayName = CSTRING(stepDownTeamleader);
                    condition = QUOTE(leader _player isNotEqualTo _player && {_player getVariable [ARR_2(QQGVAR(isTeamLeader),false)] isEqualTo true});
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};
                    statement = QUOTE(_player call FUNC(TeamLeaderStepDown));
                };
            };
        };
    };
};
