class Delivery_Mode_List: RscListBox {
    idc = MUM_IDC_CSC_Delivery_ListBox;

    style = LB_TEXTURES;

    x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(04.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(04.00 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};

    onLBSelChanged = Q(call FUNC(ui_delivery_onSelected););
};




class Delivery_Mode_Desc: RscText {
    idc = MUM_IDC_CSC_Delivery_Description;

    type = CT_STATIC;
    style = ST_MULTI;
    lineSpacing = 1;

    font = "EtelkaMonospacePro";
    SizeEx = Q(GUI_TEXT_SIZE_SMALL);


    text = "Delivery Mode Description";

    x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(08.75 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(04.25 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};
};
