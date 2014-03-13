/*
	Description:
	Checks if the object is moveable by checking the config.
	
	Parameter(s):
	_object - Type name or object to checking
	
	Returns:
	Boolean
*/

#include "macro.sqf"
private ['_object', '_cfg'];

_object = [_this, 0, "", [objNull, ""]] call BIS_fnc_param;

if ( typeName _object == "OBJECT" ) then {
	_object = typeof _object;
};

_cfg = _object call LOG_fnc_config;

count _cfg > 0 && { _cfg select CONFIG_INDEX_MOVEABLE }