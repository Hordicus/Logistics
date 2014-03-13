/*
	Description:
	Tows one vehicle to another
	
	Parameter(s):
	_veh - The vehicle that will be towing
	_towableObject - Object to be towed
	
*/

_veh           = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_towableObject = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
_behind        = [_this, 2, true, [true]] call BIS_fnc_param;

_vehSize = _veh call LOG_fnc_objectSize;
_towableSize = _towableObject call LOG_fnc_objectSize;

_bb = boundingBoxReal _veh;
_bbCenter = boundingCenter _veh;


_corner = [_bbCenter select 0, _bbCenter select 1, _bb select 1 select 0, _bb select 1 select 1, 0] call LOG_fnc_getCorner;
_towableObjectCorner = [_towableObject, 0] call LOG_fnc_getObjectCorner;
_towableObjectCenter = boundingCenter _towableObject;

if ( _behind ) then {
	_towableObject attachTo [_veh, [
		0,
		-((abs(_corner select 1) + 0.5) + (abs(_towableObjectCorner select 0))),
		-((_bbCenter select 2) - (_towableObjectCenter select 2))
	]];
}
else {
	_vehCenterOfMass = getCenterOfMass _veh;
	_towableCenterOfmass = getCenterOfMass _towableObject;
	
	_towableObject attachTo [_veh, [
		(_vehCenterOfMass select 0) - (_towableCenterOfmass select 0),
		(_vehCenterOfMass select 1) - (_towableCenterOfmass select 1),
		-((_vehSize select 2)/2 + 1)
	]];
};

if ( (_towableObjectCorner select 0) > (_towableObjectCorner select 1) ) then {
	_towableObject setDir 90;
};

_veh setVariable ['LOG_towedObject', _towableObject, true];
_towableObject setVariable ['LOG_towedTo', _veh, true];