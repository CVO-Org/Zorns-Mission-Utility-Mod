// source

[
    {
        [source] call mum_deploy_fnc_departure;
        [[worldsize/2,worldsize/2]] call mum_deploy_fnc_destination;
        [car]   call mum_deploy_fnc_destination;
        [car_1] call mum_deploy_fnc_destination;
        [car_2] call mum_deploy_fnc_destination;
        [car_3] call mum_deploy_fnc_destination;
        [car_3] call mum_deploy_fnc_destination;
        [car_4] call mum_deploy_fnc_destination;
        [car_5] call mum_deploy_fnc_destination;
        [car_6] call mum_deploy_fnc_destination;
        [car_7] call mum_deploy_fnc_destination;
    },
    [],
    1
] call CBA_fnc_waitAndExecute;
