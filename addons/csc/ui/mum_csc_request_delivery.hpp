class Delivery_Mode_List: RscListBox {
    idc = MUM_IDC_CSC_Delivery_ListBox;

    style = LB_TEXTURES;

    x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(04.50 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(04.00 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};

    onLBSelChanged = Q(call FUNC(ui_request_delivery_onSelected););
};




class Delivery_Mode_Desc: RscStructuredText {
    idc = MUM_IDC_CSC_Delivery_Description;

    type = CT_STRUCTURED_TEXT;
    style = ST_MULTI;
    lineSpacing = 1;

    SizeEx = Q(GUI_TEXT_SIZE_SMALL);

    text = "Delivery Mode Description";
	class Attributes {
		font = "EtelkaMonospacePro";
		color = "#ffffff";
		colorLink = "#D09B43";
		align = "left";
		shadow = 1;
	};

    x = Q(20.50 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
    y = Q(08.75 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
    w = Q(19.50 * GUI_GRID_CENTER_W);
    h = Q(04.25 * GUI_GRID_CENTER_H);

    colorBackground[] = {0,0,0,0.6};
};
