_container = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_item      = [_this, 1, "", [""]] call BIS_fnc_param;

_contents  = _container getVariable ['LOG_contents', []];

// Find first instance of _item
{
	if ( !isNil "_x" ) then {
		if ( typeName _x == "ARRAY" ) then {
			if ( _x select 0 == _item ) exitwith {
				if ( count _x == 2 ) then {
					_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
					_obj call LOG_fnc_pickupObject;
					
					if ( (_x select 1) == 1 ) then {
						_contents set [_forEachIndex, nil];
					}
					else {
						(_contents select _forEachIndex) set [1, (_contents select _forEachIndex select 1)-1];
					};
				}
				else {				
					_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
					_obj setDamage (_x select 1);
					
					clearMagazineCargoGlobal _obj;
					clearWeaponCargoGlobal _obj;
					clearItemCargoGlobal _obj;
					
					_mags = _x select 2;
					_weapons = _x select 3;
					_items = _x select 4;
					
					for "_i" from 0 to (count (_mags select 0)) do {
						_obj addMagazineCargoGlobal [_mags select 0 select _i, _mags select 1 select _i];
					};
					
					for "_i" from 0 to (count (_weapons select 0)) do {
						_obj addWeaponCargoGlobal [_weapons select 0 select _i, _weapons select 1 select _i];
					};
					
					for "_i" from 0 to (count (_items select 0)) do {
						_obj addItemCargoGlobal [_items select 0 select _i, _items select 1 select _i];
					};
					
					_obj call LOG_fnc_pickupObject;
					_contents set [_forEachIndex, nil];
				};
			};
		}
		else { if (typeOf _x == _item ) exitwith {
			_x call LOG_fnc_pickupObject;
			_contents set [_forEachIndex, nil];
		}};
	};
} forEach _contents;