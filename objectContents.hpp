#include "common.hpp"
#include "functions\macro.sqf"

class LOG_common {
	text = "";
	idc  = -2;
	colorBackground[] = {BACKGROUND_COLOR, 0.85};
	colorText[] = {1,1,1,1};
	color[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.8};
	colorSelect[] = {1,1,1,1};
	border = "#(argb,8,8,3)color(1,1,1,0)";
	font = "Zeppelin32";
	sizeEx = 0.03;
	type = CT_STATIC;
	style = 0;

	soundSelect[] = { "", 0, 1 };
	soundEnter[] = { "", 0, 1 };
	soundPush[] = { "", 0, 1 };
	soundClick[] = { "", 0, 1 };
	soundEscape[] = { "", 0, 1 };
};

class LOG_button {
	type = 16;
	x = 0.1;
	y = 0.1;
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {0.8784, 0.8471, 0.651, 1};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {1, 1, 1, 1};
	colorBackground2[] = {1, 1, 1, 0.4};
	idc = -2;
	style = 0;
	default = 0;
	shadow = 2;
	w = 0.183825;
	h = 0.104575;
	periodFocus = 1.2;
	periodOver = 0.8;
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\onover", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0, 0};
	soundClick[] = {"\ca\ui\data\sound\onclick", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\onescape", 0.09, 1};
	action = "";
	
	class HitZone {
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};
	class ShortcutPos {
		left = 0.0145;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	class TextPos {
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	class Attributes {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage {
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
	};
};

class LOG_ListBox : LOG_common {
	access = 0;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] = {0.8784, 0.8471, 0.651, 1};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0, 0, 0, 1};
	colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1};
	colorBackground[] = {0, 0, 0, 1};
	soundSelect[] = {"", 0.1, 1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	style = 16;
	font = "Zeppelin32";
	shadow = 2;
	sizeEx = 0.03921;
	color[] = {1, 1, 1, 1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		shadow = 0;
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};


class LOG_ListNBox : LOG_ListBox {
	type = 102;
	columns[] = {0.3, 0.6, 0.7};
	drawSideArrows = 0;
	
	idcLeft = -1;
	idcRight = -1;
};

class objectContents {

	idd = objectContentsIDD;
	movingEnable = false;
	enableSimulation = true;
	
	onLoad = "_this execVM 'logistics\event_onLoad.sqf';";
	onDestroy = "[] call LOG_fnc_destroyObjectCam;";

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
			h = safezoneH * 0.055;

			x = safezoneX + safezoneW * ( 0.6 );
			y = safezoneY + safezoneH * ( 0.64 );			
			
			text = "Unload";
			action = "call compile preprocessFileLineNumbers 'logistics\event_clickUnload.sqf'";
		};
		
		class OCcontents : LOG_ListNBox {
			idc = LOG_OCcontents_idc;
			w = safezoneW * 0.4;
			h = safezoneH * 0.3;
			x = safezoneX + safezoneW * (0.5 - 0.4/2);
			y = safezoneY + safezoneH * (0.5 - 0.3/2);
			columns[] = {0, 0.8};
		};
	};
};