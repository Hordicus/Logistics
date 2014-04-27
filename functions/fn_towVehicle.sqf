/*
	Description:
	Tows one vehicle to another
	
	Parameter(s):
	_veh - The vehicle that will be towing
	_towableObject - Object to be towed
	
*/
private ["_veh","_towableObject","_behind","_vehDim","_towDim","_bb","_bbCenter","_towableObjectCorner","_vehCenterOfMass","_towableCenterOfmass"];
_veh           = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_towableObject = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
_behind        = [_this, 2, true, [true]] call BIS_fnc_param;

detach _towableObject;

_vehDim = _veh call LOG_fnc_objectDemensions;
_towDim = _towableObject call LOG_fnc_objectDemensions;

_bb = boundingBoxReal _veh;
_bbCenter = boundingCenter _veh;


_towableObjectCorner = [_towableObject, 0] call LOG_fnc_getObjectCorner;

if ( _behind ) then {
	_towableObject attachTo [_veh, [
		0,
		-((_vehDim select 1)/2 + (_towDim select 1)/2),
		-((_vehDim select 2)/2 - (_towDim select 2)/2)
	]];
}
else {
	_vehCenterOfMass = getCenterOfMass _veh;
	_towableCenterOfmass = getCenterOfMass _towableObject;
	
	_towableObject attachTo [_veh, [
		0,
		(_vehCenterOfMass select 1) - (_towableCenterOfmass select 1),
		-((_vehDim select 2)/2 + 2)
	]];
};

if ( (_towableObjectCorner select 0) > (_towableObjectCorner select 1) ) then {
	_towableObject setDir 90;
};

_veh setVariable ['LOG_towedObject', _towableObject, true];
_towableObject setVariable ['LOG_towedTo', _veh, true];
['towedVehicle', [_veh, _towableObject]] call LOG_fnc_triggerEvent;

_veh