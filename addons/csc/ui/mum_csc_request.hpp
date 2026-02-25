class GVAR(request) {

    idd = MUM_IDD_CSC_REQUEST;

    onLoad = Q(call FUNC(ui_onLoad));
    onUnload = Q(call FUNC(ui_onUnload));

    class Controls {

        #include "mum_csc_request_crates.hpp"
        #include "mum_csc_request_delivery.hpp"
        #include "mum_csc_request_destination.hpp"

        class RscButtonMenuCancel_2700: RscButtonMenuCancel {
            x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(23.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(07.00 * GUI_GRID_CENTER_W);
            h = Q(01.25 * GUI_GRID_CENTER_H);
        };

        class RscButtonMenuOK_2600: RscButtonMenuOK {
            text = "Request";
            onLoad = "(_this#0) ctrlEnable false;";

            x = Q(28.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(23.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(12.00 * GUI_GRID_CENTER_W);
            h = Q(01.25 * GUI_GRID_CENTER_H);
        };
    };

    class ControlsBackground {
        class Background: RscText {
            idc = 1004;
            text = "";

            colorBackground[] = {0.0,0,0,0.5};

            x = Q(-0.25 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(-0.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(40.50 * GUI_GRID_CENTER_W);
            h = Q(25.50 * GUI_GRID_CENTER_H);
        };

        class Title_Background: RscText {
            idc = 1000;

            x = Q(00.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.00 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(40.00 * GUI_GRID_CENTER_W);
            h = Q(02.00 * GUI_GRID_CENTER_H);

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
            text = "MUM Custom Supply Crates Request";
            x = Q(02.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(17.50 * GUI_GRID_CENTER_W);
            h = Q(01.50 * GUI_GRID_CENTER_H);
        };

        class Title_Name: RscText {
            idc = 1002;
            text = "AccessPoint";
            style = ST_RIGHT;

            // onLoad = "_this#0 ctrlSetText name ace_player";

            x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(00.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.00 * GUI_GRID_CENTER_W);
            h = Q(01.00 * GUI_GRID_CENTER_H);
        };



        // Crates Selection
        class Crates_Subtitle_Background: RscText {
            idc = MUM_IDC_CSC_Crates_Subtitle_Background;

            x = Q(00.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(02.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(02.00 * GUI_GRID_CENTER_H);

            colorBackground[] = CVO_RED_RGBA_ARRAY_CONFIG(0.8);
        };
        class Crates_Subtitle_Text: RscText {
            idc = MUM_IDC_CSC_Crates_Subtitle_Text;

            text = "Custom Supply Crates [ 0 / 1 ]"; //--- ToDo: Localize;
            style = ST_CENTER;

            x = Q(00.25 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(02.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(01.50 * GUI_GRID_CENTER_H);
        };



        // Destination Selection
        class Destination_Subtitle_Background: RscText {
            idc = MUM_IDC_CSC_Destination_Subtitle_Background;

            colorBackground[] = CVO_RED_RGBA_ARRAY_CONFIG(0.8);

            x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(02.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(02.00 * GUI_GRID_CENTER_H);
        };
        class Destination_Subtitle_Text: RscText {
            idc = MUM_IDC_CSC_Destination_Subtitle_Text;

            text = "Destination"; //--- ToDo: Localize;
            style = ST_CENTER;

            x = Q(21.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(13.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(01.50 * GUI_GRID_CENTER_H);
        };


        // Delivery Selection
        class Delivery_Subtitle_Background: RscText {
            idc = MUM_IDC_CSC_Delivery_Subtitle_Background;

            colorBackground[] = CVO_RED_RGBA_ARRAY_CONFIG(0.8);

            x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(13.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(02.00 * GUI_GRID_CENTER_H);
        };
        class Delivery_Subtitle_Text: RscText {
            idc = MUM_IDC_CSC_Delivery_Subtitle_Text;

            text = "Delivery Mode"; //--- ToDo: Localize;
            style = ST_CENTER;

            x = Q(21.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(02.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(01.50 * GUI_GRID_CENTER_H);
        };


        // Bottom Left Status Text Bar
        class Status_Text: RscText {
            idc = MUM_IDC_CSC_Status;
            text = "Request invalid"; //--- ToDo: Localize;
            x = Q(00.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
            y = Q(23.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
            w = Q(19.50 * GUI_GRID_CENTER_W);
            h = Q(01.25 * GUI_GRID_CENTER_H);
            colorBackground[] = {0,0,0,0.8};
        };
    };
};
