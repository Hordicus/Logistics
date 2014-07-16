/*
	Description:
	Checks if the object is moveable by checking the config.
	
	Parameter(s):
	_object - Type name or object to checking
	
	Returns:
	Boolean
*/

#include "macro.sqf"
private ['_object', '_cfg', '_result', '_class'];

_object = [_this, 0, objNull, [objNull]] call BL_fnc_param;
_class = typeOf _object;

_cfg = _class call LOG_fnc_config;

_result = count _cfg > 0 && { _cfg select CONFIG_INDEX_SIZE >= 0 } && (parseNumber netId _object) > 1;

if ( _result ) then {
	_result = ['beforeMove', [_object]] call LOG_fnc_triggerEvent;
};

_result