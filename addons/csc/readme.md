> [!Caution]
> THIS NEEDS A FULL REWRITE

# Custom Supply Crates


### Currently supported values for the Hashmap
keys and default values
```sqf
createHashmapFromArray [
    ["ace_medical_facility", false],
    ["ace_medical_vehicle", false],

    ["ace_repair_facility", false],
    ["ace_repair_vehicle", false],

    ["ace_rearm_source", false],
    ["ace_rearm_source_value", 50],

    ["ace_refuel_source", false],
    ["ace_refuel_source_value", 50],
    ["ace_refuel_source_nozzlePos", [0,0,0]],

    ["ace_drag_canDrag", true],
    ["ace_drag_relPOS", [0,1.5,0]],
    ["ace_drag_dir", 0],
    ["ace_drag_ignoreWeight", true],

    ["ace_carry_canCarry", true],
    ["ace_carry_relPOS", [0,1,1]],
    ["ace_carry_dir", 0],
    ["ace_carry_ignoreWeight", false],

    ["ace_cargo_add_spareWheels", 0],
    ["ace_cargo_add_jerrycans", 0],
    ["ace_cargo_add_tracks", 0],
    // Space will be automatically adjusted

    ["ace_cargo_setSpace", 0],
    ["ace_cargo_setSize", "DEFAULT"]
]
```
## CBA Events
`mum_csc_api_crateSpawnedServer` - ServerEvent
