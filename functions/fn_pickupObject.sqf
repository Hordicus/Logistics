private ['_object', '_objSize', '_maxHeight', '_maxLength'];
_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;

if ( !isNil "LOG_currentObject" ) then {
	detach LOG_currentObject;
};

LOG_currentObject = _object;
_objSize   = LOG_currentObject call LOG_fnc_objectSize;
_maxLength = _objSize select 1;
_maxHeight = _objSize select 2;

_object attachTo [player, [
	0,
	(_maxLength/2) + 5,
	_maxHeight/2
]];

LOG_currentObject