# Unhide Layer Action

## What this?
Creates an Ace Interaction on an object. The object needs to be near a set of editor objects inside a layer with a certain name.
When the action is being executed, it simulates the building of "something", by unhiding the objects in the defined layer - one after another - based on objects ASL from lowest to highest object.
Multiple people can work together and build things faster.


## Showcase
[![Showcase](https://img.youtube.com/vi/buWmeaKfe0M/0.jpg)](https://www.youtube.com/watch?v=buWmeaKfe0M)


## How to Use

### Main Functions
#### [`mum_ula_fnc_register`](/addons/ula/functions/fn_register.sqf)
This function will do all the setup needed. It is to be apllied on the box "that carries the building supplies".

### Additional Functions
#### [`mum_ula_fnc_register_cleanup`](/addons/ula/functions/fn_register_cleanup.sqf)
This function registers a layername, which' objects are to be deleted once a layer has been completely revealed.

### Additional FUnction: `mum_ula_fnc_register_cleanup`

This function controls

## Notes:

Median Position: The "Median" Position will be calculated by finding the middlepoint of entities who are part of the layer.

This feature only "unhides" each object by using `_obj hideObjectGlobal false`.

Attributes regarding, Simulation, Simple Object have to be managed in the Editor.

> [!CAUTION]
Objects set as "LOCAL ONLY" will not work in Multiplayer.
