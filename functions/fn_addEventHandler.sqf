/*
	Description:
	Add event handler for specified event.
	
	Events:
	beforeTow: Runs in isTowable function. Return false to alter isTowable behaviour.
	beforeMove: Runs in isMoveable function. Return false to alter isMoveable behaviour.
	
	Parameter(s):
	_event
	_code - Must return false to stop action
	
	Returns:
	Index - Used to remove extra check
*/

private ['_event', '_code', '_index'];

_event = [_this, 0, '', ['']] call BL_fnc_param;
_code = [_this, 1, {}, [{}]] call BL_fnc_param;


LOG_eventHandlers = missionNamespace getVariable ['LOG_eventHandlers', []];
_index = count LOG_eventHandlers;
LOG_eventHandlers set [_index, [_event, _code]];

_index