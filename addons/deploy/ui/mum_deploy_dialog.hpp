class GVAR(dialog) {

    idd = MUM_IDD_DEPLOY;

    onLoad = Q(call FUNC(ui_onLoad));
    onUnload = Q(call FUNC(ui_onUnload));

    class Controls {

        class List_Destinations: RscListBox {
            idc = 1500;

            style = LB_TEXTURES;

            onLBSelChanged = Q(call FUNC(ui_onLBSelChanged););

            x = Q(20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(02.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.5 * GUI_GRID_CENTER_W);
            h = Q(20.5 * GUI_GRID_CENTER_H);
            colorBackground[] = {0,0,0,0.8};
        };


        class RscButtonMenuCancel_2700: RscButtonMenuCancel {
            x = Q(20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(23.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(07.0 * GUI_GRID_CENTER_W);
            h = Q(01.2 * GUI_GRID_CENTER_H);
        };


        class RscButtonMenuOK_2600: RscButtonMenuOK {
            text = "Deploy";
            onLoad = "(_this#0) ctrlEnable false;";

            x = Q(28.0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(23.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(12.0 * GUI_GRID_CENTER_W);
            h = Q(01.2 * GUI_GRID_CENTER_H);
        };
    };


    class ControlsBackground {
        class Background: RscText {
            idc = 1004;
            text = "";

            colorBackground[] = {0.0,0,0,0.5};

            x = Q(-0.25 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(-0.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(40.5 * GUI_GRID_CENTER_W);
            h = Q(25.5 * GUI_GRID_CENTER_H);
        };

        class Title_Background: RscText {
            idc = 1000;
            x = Q(00.0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(40.0 * GUI_GRID_CENTER_W);
            h = Q(02.0 * GUI_GRID_CENTER_H);
            colorBackground[] = CVO_RED_RGBA_ARRAY_CONFIG(0.8);
        };


        class Title_Icon: RscPicture {
            idc = 1200;
            text = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";
            x = Q(00.25 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(01.50 * GUI_GRID_CENTER_W);
            h = Q(01.50 * GUI_GRID_CENTER_H);
        };


        class Title_Text: RscText {
            idc = 1001;
            text = "CVO Deploy";
            x = Q(02.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(17.5 * GUI_GRID_CENTER_W);
            h = Q(01.5 * GUI_GRID_CENTER_H);
        };


        class Title_Name: RscText {
            idc = 1002;
            text = "Username";
            style = ST_RIGHT;

            onLoad = "_this#0 ctrlSetText name ace_player";

            x = Q(20.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.0 * GUI_GRID_CENTER_W);
            h = Q(01.0 * GUI_GRID_CENTER_H);
        };


        class Map_Destinations: RscMapControl {
            idc = 1600;

            type = CT_MAP;

            showMarkers = 0;
            moveOnEdges = 0;

            scaleMin = 0.03;

            x = Q(00.0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(02.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.5 * GUI_GRID_CENTER_W);
            h = Q(20.5 * GUI_GRID_CENTER_H);
        };


        class Status_Text: RscText {
            idc = 1003;
            text = "No Destination selected"; //--- ToDo: Localize;
            x = Q(00.0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(23.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.5 * GUI_GRID_CENTER_W);
            h = Q(01.2 * GUI_GRID_CENTER_H);
            colorBackground[] = {0,0,0,0.8};
        };
    };
};
