# Fonts
Idk. its two new fonts. One is grafitti style, the other is stencil style. Only afterwards did i discover that `ACE_Stencil` is a thing.

![alt text](/img/readme/fonts.png)

- `shaffilastri`
- `VTKSSMASH`


## [How to use](https://community.bistudio.com/wiki/Procedural_Textures#Text)

`#(rgb,512,512,3)text(0,0,"VTKSSMASH",0.3,"#0000ff7f","#ff0000","VTKSSMASH")`

`#(rgb,512,512,3)text(0,0,"shaffilastri",0.3,"#0000ff7f","#ff0000","shaffilastri")`

`#(rgb,512,512,3)text(1,1,"VTKSSMASH",0.25,"#00000000","#690000","No Shooting\nduring\nBriefing\nor Debrief")`

### Magic of procedural textures

```sqf
if !(isNil "texture_01") then {
    private _texture = switch (player getVariable ["interpreter", false]) do {
        case true: { '#(rgb,512,512,3)text(0,0,"shaffilastri",0.3,"#00000000","#690000","they poisioned us")' };
        case false: { '#(rgb,512,512,3)text(0,0,"shaffilastri",0.3,"#00000000","#690000","dsenyto us pihoie")' };
    };

    texture_01 setObjectTexture [0, _texture];
};
```


```sqf

[ {

    _scrambled = [
        "Stprupo eht AIFS",
        "eW igbrn aeepc",
        "eW ingrb ltiytisba",
        "",
        "ejectR UAN",
        "ltasiatpiC gpis"
    ];

    _text = [
        "Support the SFIA",
        "We bring peace",
        "We bring stability",
        "",
        "Reject UNA",
        "Capitalist pigs"
    ];

    _isTerp = player getVariable ["interpreter", false];

    _text = switch (_isTerp) do {
        case true:  { _text joinString "\n"; };
        case false: { _rand joinString "\n"; };
    };

    _prodText = format ['#(rgb,512,512,3)text(1,1,"VTKSSMASH",0.1,"#ffcc5f","#690000",%1)', _text];
    [_this#0, _prodText, _text] call BIS_fnc_initInspectable;

 } , [this], 10] call CBA_fnc_waitAndExecute;


```
