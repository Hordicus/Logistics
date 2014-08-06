/*
	Description:
	Calculates rough distance between two objects
	taking into account of the bounding boxes
	of the two objects.
	
	Parameter(s):
	_obj1
	_obj2
	
	Returns:
	Distance
*/

private ["_obj1","_obj2","_obj1Pos","_obj2Pos","_obj1PosGround","_obj2PosGround","_distance","_obj1Dim","_obj1MaxSize","_obj2Dim","_obj2MaxSize","_heightDiff"];

_obj1 = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_obj2 = [_this, 1, objNull, [objNull]] call BIS_fnc_param;

_obj1Pos = getPosATL _obj1;
_obj2Pos = getPosATL _obj2;

_obj1PosGround = +_obj1Pos;
_obj1PosGround set [2, 0];

_obj2PosGround = +_obj2Pos;
_obj2PosGround set [2, 0];

_distance = _obj1PosGround distance _obj2PosGround;

_obj1Dim = _obj1 call LOG_fnc_objectDemensions;
_obj1MaxSize = (_obj1Dim select 0) max (_obj1Dim select 1);

_obj2Dim = _obj2 call LOG_fnc_objectDemensions;
_obj2MaxSize = (_obj2Dim select 0) max (_obj2Dim select 1);

_heightDiff = abs((_obj1Pos select 2) - (_obj2Pos select 2));

(_distance - _obj1MaxSize/2 - _obj2MaxSize/2 + _heightDiff)