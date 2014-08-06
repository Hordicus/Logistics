/*
	Description:
	Returns the size for a type of object as defined in the config
	
	Parameter(s):
	_type - Type of object to check
	
	Returns:
	Size of object
*/

#include "macro.sqf"
private ['_type', '_cfg', '_size'];
_type = [_this, 0, "", ["", objNull]] call BL_fnc_param;

if ( typeName _type == "OBJECT" ) then {
	_type = typeOf _type;
};

_cfg = _type call LOG_fnc_config;
_size = -1;

if ( count _cfg > 0 ) then {
	_size = _cfg select CONFIG_INDEX_SIZE;
};

_size