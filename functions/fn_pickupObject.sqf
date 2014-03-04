private ['_object', '_objSize', '_maxHeight', '_maxLength'];
_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( !isNil "LOG_currentObject" ) then {
	detach LOG_currentObject;
};

LOG_currentObject = _object;

[] call LOG_fnc_positionHeldObject;