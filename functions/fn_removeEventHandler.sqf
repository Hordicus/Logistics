/*
	Description:
	Remove event handler.
	
	Parameter(s):
	_index - Index returned from addEventHandler
	
	Returns:
	Event handler that was removed
*/

private ['_event', '_index'];
_index = [_this, 0, -1, [0]] call BL_fnc_param;

_event = [];

if ( !isNil {LOG_eventHandlers select _index} ) then {
	_event = LOG_eventHandlers select _index;
	LOG_eventHandlers set [_index, nil];
};

_event