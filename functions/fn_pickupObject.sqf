private ['_object', '_objSize', '_maxHeight', '_maxLength'];
_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( !isNil "LOG_currentObject" ) then {
	detach LOG_currentObject;
};

LOG_currentObject = _object;

// Variables to remember current settings in.
// Doubles as default values.
LOG_pos_distanceFromPlayer = 5;
LOG_pos_offsetHeight = 0;
LOG_pos_centerFromPlayer = 0;
LOG_pos_direction = 0;

[] call LOG_fnc_positionHeldObject;