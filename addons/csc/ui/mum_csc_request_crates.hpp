class Crates_ListNBox: RscListNBox {
    idc = MUM_IDC_CSC_Crates_ListNBox;

    type = CT_LISTNBOX;
    style = LB_TEXTURES;

    onLBSelChanged = Q(call FUNC(ui_crates_onLBSelChanged););

    x = Q(00.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(04.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(07.50 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.8};

    drawSideArrows = 0;

    idcLeft = MUM_IDC_CSC_Crates_ListNBox_arrowMinus;
    idcRight = MUM_IDC_CSC_Crates_ListNBox_arrowPlus;

    columns[] = { 0.1, 0.8 };

};

class ArrowLeft: RscButton {

    idc = MUM_IDC_CSC_Crates_ListNBox_arrowMinus;

    onButtonClick = QUOTE([ARR_2(-1,(_this#0))] call FUNC(ui_crates_update););

    text = "-";

    SizeEx = Q(GUI_TEXT_SIZE_LARGE);    // 0.5

    style = ST_CENTER;

    // fade = 1;
    // enable = 0;

    x = -100; // Q(00.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = -100; // Q(00.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(01.00 * GUI_GRID_CENTER_W);
    h = Q(01.00 * GUI_GRID_CENTER_H);

    colorBackground[] = { 1, 1, 1, 0 };
    colorBackgroundActive[] = { 1, 1, 1, 0 };
    colorBackgroundDisabled[] = { 1, 1, 1, 0 };
    colorFocused[] = { 1, 1, 1, 0 };
    colorShadow[] = { 1, 1, 1, 0 };
    borderSize = 0;

    shadow = 0;

};

class ArrowRight: ArrowLeft {

    idc = MUM_IDC_CSC_Crates_ListNBox_arrowPlus;

    onButtonClick = QUOTE([ARR_2(1,(_this#0))] call FUNC(ui_crates_update););

    text = "+";
};

class Crates_Description: RscText {
    idc = MUM_IDC_CSC_Crates_ListNBox_Description;

    type = CT_STATIC;
    style = ST_MULTI;

    lineSpacing = 1;

    font = "EtelkaMonospacePro";
    SizeEx = Q(GUI_TEXT_SIZE_SMALL * 0.8);


    text = "BeebBoob Error";

    x = Q(00.00 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(13.25 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(10.00 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};

};
