_veh = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_towedObject = _veh getVariable ['LOG_towedObject', objNull];

detach _towedObject;

if ( local _towedObject ) then {
	_towedObject setVelocity velocity _veh;
}
else {
	LOG_PVAR_SETVELOCITY_SERVER = [_towedObject, velocity _veh];
	publicVariableServer "LOG_PVAR_SETVELOCITY_SERVER";
};

_veh setVariable ['LOG_towedObject', nil, true];
_towedObject setVariable ['LOG_towedTo', nil, true];

_towedObject