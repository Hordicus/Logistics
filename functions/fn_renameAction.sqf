/*
	Description:
	Renames an action using setUserActionText
	
	Parameter(s):
	_code - Code used to identify action
	_text - Text to use for user action
	
*/

private ['_code', '_text'];

_code = [_this, 0, '', ['']] call BIS_fnc_param;
_text = [_this, 1, '', ['']] call BIS_fnc_param;

{
	if ( _x select 0 == _code ) exitwith {
		player setUserActionText [_x select 1, _text];
	};
	
} count LOG_actionIds;