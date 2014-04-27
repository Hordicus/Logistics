#include "functions\macro.sqf"
_item = (_this select 0) lnbData[_this select 1, 0];

[_item, "rendertarget45"] call LOG_fnc_createObjectCam;

ctrlShow [LOG_OCpreview_idc, true];
ctrlSetText [LOG_OCpreview_idc, "#(argb,256,256,1)r2t(rendertarget45,1.0)"];