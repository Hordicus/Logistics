#include "functions\macro.sqf"

private ["_row","_item"];
_row = lnbCurSelRow LOG_OCcontents_idc;
if ( _row > -1 ) then {
	// _item = ((findDisplay objectContentsIDD) displayCtrl LOG_OCcontents_idc) lnbText [_row, 1];
	_item = lnbData [LOG_OCcontents_idc, [_row, 1]];
	[LOG_showingContentsOf, _item] call LOG_fnc_unloadItem;
	closeDialog 0;
};