/*
	Description:
	Returns total size of all items in a container
	
	Parameter(s):
	_container - Object to check or array of items
	
	Returns:
	Room used
*/
#include "macro.sqf"
private ['_container', '_contents', '_count'];

_container = [_this, 0, [], [[], objNull]] call BIS_fnc_param;
_contents = [];
_count = 0;

if ( typeName _container == "ARRAY" ) then {
	_contents = _container;
}
else {
	_contents = _container getVariable ['LOG_contents', []];
};

{
	if ( !isNil "_x" ) then {
		private ['_cfg'];
		_cfg = [];
		_numberOfItems = 1;
		
		if ( typeName _x == "ARRAY" ) then {
			_cfg = (_x select 0) call LOG_fnc_config;
			
			if ( count _x == 2 ) then {
				_numberOfItems = _x select 1;
			};
		}
		else {
			_cfg = (typeOf _x) call LOG_fnc_config;
		};

		if ( count _cfg > 0 ) then {
			_count = _count + (_cfg select CONFIG_INDEX_SIZE) * _numberOfItems;
		};
	};
} forEach _contents;

_count