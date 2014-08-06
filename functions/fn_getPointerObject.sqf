/*
	Description:
	Gets the object the player is pointing at.
	Can be used to check if an object is within a certain distance
	from the player by passing a _distance.
	
	Idea from https://github.com/Tenga/Arma-3-Fluid-Door-Opening/blob/master/fnc/fn_fluidDoorOpening_init.sqf
	
	Parameter(s):
	_distance - How far to check for pointer object. Default 5m
	
	Returns:
	Array - List of objects that the player is pointed at within _distance
*/

private['_distance', '_cameraPosition', '_finalPosition', '_angle'];
_distance = [_this, 0, 5, [0]] call BIS_fnc_param;

_cameraPosition = eyePos player;
_finalPosition = [_cameraPosition, _distance, getDir player] call BIS_fnc_relPos;

_angle = (([positionCameraToWorld [0,0,0], positionCameraToWorld [0,0,1]] call BIS_fnc_vectorFromXtoY) call BIS_fnc_unitVector) select 2;
_finalPosition set [2, _angle*_distance + (_cameraPosition select 2)];

lineIntersectsWith [_cameraPosition, _finalPosition]