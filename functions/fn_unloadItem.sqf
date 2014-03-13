private ["_container","_item","_contents","_obj","_object","_mags","_weapons","_items","_i"];

_container = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_item      = [_this, 1, "", [""]] call BIS_fnc_param;

_contents  = _container getVariable ['LOG_contents', []];
_obj = objNull;

// Find first instance of _item
{
	if ( !isNull _obj ) exitwith{};

	if ( !isNil "_x" ) then {
		if ( typeName _x == "ARRAY" ) then {
			if ( _x select 0 == _item ) then {
				if ( count _x == 2 ) then {
					_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
					
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
					
					_contents set [_forEachIndex, nil];
				};
			};
		}
		else { if (typeOf _x == _item ) then {
			_obj = _x;
			_contents set [_forEachIndex, nil];
		}};
	};
} forEach _contents;

_obj call LOG_fnc_pickupObject;