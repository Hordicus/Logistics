/*
	Description:
	Checks if a given object is towable. If a vehicle is passed in
	as the second object it will check if it's towable by that vehicle.
	
	Parameter(s):
	_object - Object to check towability of
	_veh    - check if _object can be towed by _veh
	
	Returns:
	Boolean
*/
private ["_object","_veh","_objCfg","_result","_vehCfg"];
#include "macro.sqf"

_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_veh    = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

_objCfg = (typeOf _object) call LOG_fnc_config;
_result = false;

if ( count _objCfg > 0 && { _objCfg select CONFIG_INDEX_WEIGHT >= 0 }) then {
	if ( !isNull _veh ) then {
		_vehCfg = (typeOf _veh) call LOG_fnc_config;
		_result = count _vehCfg > 0 && _vehCfg select CONFIG_INDEX_TOWINGCAPACITY >= _objCfg select CONFIG_INDEX_WEIGHT
			&& isNull (_veh getVariable ['LOG_towedObject', objNull])
			&& isNull (_object getVariable ['LOG_towedTo', objNull]);
	}
	else {
		_result = true;
	};
};

if ( _result ) then {
	_result = ['beforeTow', [_object, _veh]] call LOG_fnc_triggerEvent;
};

_result