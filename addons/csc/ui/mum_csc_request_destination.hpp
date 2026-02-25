class Destination_List: RscListBox {
    idc = MUM_IDC_CSC_Destination_ListBox;

    style = LB_TEXTURES;

    x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(15.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(04.00 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};

    onLBSelChanged = Q(call FUNC(ui_destination_onSelected););
};

class Destination_Mode_Desc: RscText {
    idc = MUM_IDC_CSC_Destination_Description;

    type = CT_STATIC;
    style = ST_MULTI;
    lineSpacing = 1;

    font = "EtelkaMonospacePro";
    SizeEx = Q(GUI_TEXT_SIZE_SMALL);


    text = "Destination Description";

    x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(19.75 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(03.50 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};
};
