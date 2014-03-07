_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_towedObject = _veh getVariable ['LOG_towedObject', objNull];

detach _towedObject;
_towedObject setVelocity velocity _veh;

_veh setVariable ['LOG_towedObject', nil, true];

_towedObject