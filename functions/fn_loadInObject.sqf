_object = [_this, 0, "", ["", objNull]] call BIS_fnc_param;
_container = [_this, 1, objNull, [objNull]] call BIS_fnc_param;
_cache = [_this, 2, true, [true]] call BIS_fnc_param;

_contents = _container getVariable ['LOG_contents', []];
_type = "";

if ( typeName _object == "STRING" ) then {
	_index = -1;
	
	{
		if ( typeName _x == "ARRAY" && { count _x == 2 } ) exitwith {
			_index = _forEachIndex;
		};
	} forEach _contents;
	
	(_contents select _index) set [1, (_contents select _index select 1)+1];
}
else { if ( typeName _object == "OBJECT" ) then {
	_type = typeOf _object;

	if ( _cache ) then {
		_info = [
			typeOf _object,
			damage _object,
			getMagazineCargo _object,
			getWeaponCargo _object,
			getItemCargo _object
		];
		
		_contents set [count _contents, _info];
		deleteVehicle _object;
	}
	else {
		_contents set [count _contents, _object];
	};
}};

_container setVariable ['LOG_contents', _contents, true];