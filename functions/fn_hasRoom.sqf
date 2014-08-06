/*
	Description:
	Checks if _container has room for _object
	
	Parameter(s):
	_container
	_object - Object or object class
	
	Returns:
	Boolean
*/

#include "macro.sqf"
private ['_container', '_object', '_roomUsed', '_containerSize', '_objectSize'];

_container = [_this, 0, objNull, [objNull]] call BL_fnc_param;
_object    = [_this, 1, "", [objNull, ""]] call BL_fnc_param;

if ( typeName _object == "OBJECT" ) then {
	_object = typeof _object;
};

_roomUsed = _container call LOG_fnc_roomUsed;
_containerSize = _container call LOG_fnc_containerSize;
_objectSize = (_object call LOG_fnc_config) select CONFIG_INDEX_SIZE;

(_roomUsed + _objectSize) <= _containerSize