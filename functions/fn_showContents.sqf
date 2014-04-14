#include "macro.sqf"

private ['_container', '_dialog'];

_container = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_dialog = createDialog 'objectContents';
_contents = _container getVariable ['LOG_contents', []];

LOG_showingContentsOf = _container;

_types = [];
_rows = [];

_used = [_contents] call LOG_fnc_roomUsed;
_maxCap = _container call LOG_fnc_containerSize;

ctrlSetText [LOG_OCroom_idc, format['%1 / %2', _used, _maxCap]];
ctrlSetText [LOG_OCtitle_idc, format['%1 Contents', getText (configFile >> "CfgVehicles" >> (typeOf LOG_showingContentsOf) >> "displayName")]];

{   
	if ( !isNil "_x" ) then {
		_type = "";
		_count = 0;
		
		if ( typeName _x == "ARRAY" ) then {
			if ( count _x == 2 ) then {
				_type = _x select 0;
				_count = _x select 1;
			}
			else {
				_type = _x select 0;
				_count = 1;
			};
		};
		
		if ( typeName _x == "OBJECT" ) then {
			_type = typeOf _x;
			_count = 1;
		};
		
		_index = _types find _type;
		
		if ( _index > -1 ) then {
			(_rows select _index) set [1, ((_rows select _index) select 1)+_count];
		}
		else {
			_rows set [count _rows, [_type, _count]];
			_types set [count _types, _type];
		};
	};
} forEach _contents;

{
	_itemName = getText ( configFile >> "CfgVehicles" >> (_x select 0) >> "displayName" );
	_count = _x select 1;
	
	_row = lnbAddRow [LOG_OCcontents_idc, ["", _itemName, str _count]];
	lnBSetData [LOG_OCcontents_idc, [_row, 1], _x select 0];
} forEach _rows;