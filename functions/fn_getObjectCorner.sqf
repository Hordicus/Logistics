/*
	Description:
	Gets the corner of an object using LOG_fnc_getCorner
	
	Parameter(s):
	_object
	_direction
	
	Returns:
	_corner
	
*/

private ['_object', '_direction', '_bb', '_bbCenter', '_corner'];

_object = [_this, 0, LOG_currentObject, [objNull]] call BL_fnc_param;
_direction = [_this, 1, getDir _object, [0]] call BL_fnc_param;

_bb = boundingBox _object;
_bbCenter = boundingCenter _object;


_corner = [_bbCenter select 0, _bbCenter select 1, _bb select 1 select 0, _bb select 1 select 1, _direction] call LOG_fnc_getCorner;

_corner