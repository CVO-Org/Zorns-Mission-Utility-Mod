class GVAR(gridCoordinates) {

    idd = MUM_IDD_CSC_GRIDCORD;

    onLoad   = Q(call FUNC(ui_grid_onLoad));
    onUnload = Q(call FUNC(ui_grid_onUnload));

    class Controls {



        class inputX: RscEdit {

            onEditChanged = Q(call FUNC(ui_grid_onEditChanged));

            idc = MUM_IDC_CSC_GRID_X;
            text = "";

            font = "EtelkaMonospacePro";
            SizeEx = Q(GUI_TEXT_SIZE_LARGE);
            style = ST_FRAME;

            colorBackground[] = {0,0,0,0.6};

            x = Q(10.250 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(11.500 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(09.500 * GUI_GRID_CENTER_W);
            h = Q(01.250 * GUI_GRID_CENTER_H);

        };

        class inputY: RscEdit {
            idc = MUM_IDC_CSC_GRID_Y;
            text = "";

            onEditChanged = Q(call FUNC(ui_grid_onEditChanged));

            font = "EtelkaMonospacePro";
            SizeEx = Q(GUI_TEXT_SIZE_LARGE);
            style = ST_FRAME;

            colorBackground[] = {0,0,0,0.6};

            x = Q(20.250 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(11.500 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(09.500 * GUI_GRID_CENTER_W);
            h = Q(01.250 * GUI_GRID_CENTER_H);
        };

        class RscButtonMenuCancel_2700: RscButtonMenuCancel {
            x = Q(10.250 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(14.500 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(07.000 * GUI_GRID_CENTER_W);
            h = Q(01.250 * GUI_GRID_CENTER_H);
        };

        class RscButtonMenuOK_2600: RscButtonMenuOK {
            text = "Request";
            onLoad = "(_this#0) ctrlEnable false;";

            x = Q(17.750 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(14.500 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(12.000 * GUI_GRID_CENTER_W);
            h = Q(01.250 * GUI_GRID_CENTER_H);
        };
    };

    class ControlsBackground {
        class Background: RscText {
            idc = 1004;
            text = "";

            colorBackground[] = {0.0,0,0,0.5};

            x = Q(09.875 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(09.000 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(20.250 * GUI_GRID_CENTER_W);
            h = Q(07.000 * GUI_GRID_CENTER_H);
        };

        class Title_Background: RscText {
            idc = 1000;

            x = Q(10.000 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(09.250 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(20.000 * GUI_GRID_CENTER_W);
            h = Q(02.000 * GUI_GRID_CENTER_H);

            colorBackground[] = CVO_RED_RGBA_ARRAY_CONFIG(0.8);
        };

        class Title_Icon: RscPicture {
            idc = 1200;
            text = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";
            x = Q(10.250 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(09.500 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(01.500 * GUI_GRID_CENTER_W);
            h = Q(01.500 * GUI_GRID_CENTER_H);
        };

        class Title_Text: RscText {
            idc = 1001;
            text = "Provide Coordinates";
            x = Q(12.500 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(09.500 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(07.500 * GUI_GRID_CENTER_W);
            h = Q(01.500 * GUI_GRID_CENTER_H);
        };

        class Title_Name: RscText {
            idc = 1002;
            text = "";
            style = ST_RIGHT;

            // onLoad = "_this#0 ctrlSetText name ace_player";

            x = Q(20.500 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(09.750 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(09.250 * GUI_GRID_CENTER_W);
            h = Q(01.000 * GUI_GRID_CENTER_H);
        };

        // Bottom Left Status Text Bar
        class Status_Text: RscText {
            idc = MUM_IDC_CSC_Status;
            text = CSTRING(ui_requestInvalid);
            x = Q(10.250 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(13.000 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.500 * GUI_GRID_CENTER_W);
            h = Q(01.250 * GUI_GRID_CENTER_H);
            colorBackground[] = {0,0,0,0.8};
        };
    };
};
