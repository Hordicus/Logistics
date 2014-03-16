/*
	Description:
	Triggers an event with the given parameters
	and returns the result of all event handlers.
	
	Parameter(s):
	_event - Name of event to trigger
	_params - Array of params to pass to event handlers
	
	Returns:
	Bool - Result of all event handlers ANDed
*/

private ['_event', '_params', '_results'];
_event = [_this, 0, '', ['']] call BIS_fnc_param;
_params = [_this, 1, [], [[]]] call BIS_fnc_param;

_result = true;

{
	if ( !isNil "_x" && { _x select 0 == _event } ) then {
		_return = _params call (_x select 1);
		
		if ( !isNil "_return" && {typeName _return == "BOOL"} ) then {
			_result = _result && _return;
		};
	};

} count LOG_eventHandlers;

_result