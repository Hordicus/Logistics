#include "common.hpp"
#include "functions\macro.sqf"

class LOG_common {
	style = 0;
	type = 0;
	text = "";
	idc  = -1;
	colorBackground[] = {0,0,0,0.5};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.8};
	colorSelect[] = {1,1,1,1};
	soundSelect[] = {"", 0.1, 1};
	border = "#(argb,8,8,3)color(1,1,1,0)";
	font = FontM;
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
};

class LOG_button : LOG_common {
	type = CT_BUTTON;
	style = 0;
	
	default = false;
	colorFocused[] = {0,0,0,0.5};
	colorBackgroundActive[] = {1,1,1,1};
	
	// colorBackground[] = {1,0,0,0.5};
	colorBackgroundDisabled[] = {1,1,1,1};
	action = "";
	
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0;
	offsetPressedY = 0;
	colorShadow[] = {0,0,0,0};
	colorBorder[] = {0,0,0,0};
	borderSize = 0;
	
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
	
	// Is there a better way?
	onMouseEnter = "(_this select 0) ctrlSetTextColor [0,0,0,1];";
	onMouseExit  = "(_this select 0) ctrlSetTextColor [1,1,1,1];";
};

class LOG_ListBox : LOG_common {
	type = CT_LISTBOX;
	style = ST_MULTI;
	wholeHeight = 0.45;
	rowHeight = 0.045;
	maxHistoryDelay = 1;
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	
	class ListScrollBar {
		color[] = {1, 1, 1, 1};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 1};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
};


class LOG_ListNBox : LOG_ListBox {
	type = 102;
	columns[] = {0.3, 0.6, 0.7};
	drawSideArrows = 0;
	
	idcLeft = -2;
	idcRight = -2;
};

class objectContents {

	idd = objectContentsIDD;
	movingEnable = false;
	enableSimulation = true;
	
	onLoad = "_this execVM 'logistics\event_onLoad.sqf';";

	class controlsBackground {
		class OCtitle : LOG_common {
			text = "Object Contents";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2);
			w = safezoneW * 0.4;
			h = safezoneH * 0.03;
			x = safezoneX + safezoneW * (0.5 - 0.4/2);
			y = safezoneY + safezoneH * (0.5 - 0.3/2 - 0.005 - 0.03);
			idc = LOG_OCtitle_idc;
		};
		
		class OCbackground : LOG_common {
			w = safezoneW * 0.4;
			h = safezoneH * 0.3;
			x = safezoneX + safezoneW * (0.5 - 0.4/2);
			y = safezoneY + safezoneH * (0.5 - 0.3/2);
		};
		
		class OCroom : OCtitle {
			text = "0 / 0";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

			style = ST_RIGHT;
			colorBackground[] = {0,0,0,0};
			idc = LOG_OCroom_idc;
		};
	};

	class controls {
		class OCunload : LOG_button {
			w = safezoneW * 0.1;
			h = safezoneH * 0.02;
			x = safezoneX + safezoneW * (0.5 + 0.4/2 - 0.1);
			y = safezoneY + safezoneH * (0.5 + 0.3/2 + 0.005);
			
			text = "Unload";
			action = "call compile preprocessFileLineNumbers 'logistics\event_clickUnload.sqf'";
		};
		
		class OCcontents : LOG_ListNBox {
			idc = LOG_OCcontents_idc;
			w = safezoneW * 0.445;
			h = safezoneH * 0.3;
			x = safezoneX + safezoneW * (0.5 - 0.4/2 - 0.022);
			y = safezoneY + safezoneH * (0.5 - 0.3/2);
			columns[] = {0, 0.05, 0.8};

		};
	};
};