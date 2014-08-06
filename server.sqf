#define ASNUMBER(NUMBER) (if(typeName (NUMBER) != "SCALAR") then {parseNumber (NUMBER)} else {NUMBER})

if ( !isServer ) exitwith{};
[] spawn {

LOG_PVAR_UNLOADITEM = objNull;
LOG_PVAR_SETVELOCITY_SERVER = objNull;
LOG_PVAR_setOwner = [objNull, objNull];

"LOG_PVAR_UNLOADITEM" addPublicVariableEventHandler {
	private ["_client","_container","_item","_obj","_contents","_mags","_weapons","_items"];
	_client    = owner ([_this select 1, 0, objNull, [player]] call BIS_fnc_param);
	_container = [_this select 1, 1, objNull, [objNull]] call BIS_fnc_param;
	_item      = [_this select 1, 2, "", [""]] call BIS_fnc_param;
	
	#ifdef LOG_LOGGING
	diag_log format['Player %1 (#%2) requesting %3 from %4',
		name (_this select 1 select 0),
		_client,
		_item,
		_container
	];
	
	#endif
	
	_obj = objNull;
	_contents = _container getVariable ['LOG_contents', []];
	
	// Find first instance of _item
	{
		if ( !isNull _obj ) exitwith{};

		if ( !isNil "_x" ) then {
			if ( typeName _x == "ARRAY" ) then {
				if ( _x select 0 == _item ) then {
					if ( count _x == 2 ) then {
						_obj = [_x select 0, [0,0,0]] call (('createVehicle' call LOG_fnc_config) select 1);

						if ( ASNUMBER(_x select 1) == 1 ) then {
							_contents set [_forEachIndex, "REMOVE"];
							_contents = _contents - ["REMOVE"];
						}
						else {
							(_contents select _forEachIndex) set [1, ASNUMBER(_x select 1)-1];
						};
					}
					else {
						_obj = [_x select 0, [0,0,0]] call (('createVehicle' call LOG_fnc_config) select 1);
						_obj setDamage ASNUMBER(_x select 1);
						
						clearMagazineCargoGlobal _obj;
						clearWeaponCargoGlobal _obj;
						
						_mags = _x select 2;
						_weapons = _x select 3;
						
						for "_i" from 0 to (count (_mags select 0)) do {
							_obj addMagazineCargoGlobal [_mags select 0 select _i, ASNUMBER(_mags select 1 select _i)];
						};
						
						for "_i" from 0 to (count (_weapons select 0)) do {
							_obj addWeaponCargoGlobal [_weapons select 0 select _i, ASNUMBER(_weapons select 1 select _i)];
						};
						
						_obj setVariable ['LOG_contents', _x select 4, true];
						
						_contents set [_forEachIndex, "REMOVE"];
						_contents = _contents - ["REMOVE"];
					};
				};
			}
			else { if (typeOf _x == _item ) then {
				_x enableSimulation true;
				_obj = _x;
				_contents set [_forEachIndex, nil];
			}};
		};
	} forEach _contents;
	
	_container setVariable ['LOG_contents', _contents, true];
	LOG_PVAR_UNLOADITEM_RES = _obj;
	_client publicVariableClient "LOG_PVAR_UNLOADITEM_RES";
};

"LOG_PVAR_SETVELOCITY_SERVER" addPublicVariableEventHandler {
	private ["_client","_veh","_velocity"];
	_veh      = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_velocity = [_this select 1, 1, [0,0,0], [[]], [3]] call BIS_fnc_param;
	_client   = owner _veh;

	if ( local _veh ) then {
		_veh setVelocity _velocity;
	}
	else {	
		// Pass info on to owner of object
		LOG_PVAR_SETVELOCITY = [_veh, _velocity];
		_client publicVariableClient "LOG_PVAR_SETVELOCITY";
	};
};

"LOG_PVAR_setOwner" addPublicVariableEventHandler {
	(_this select 1 select 1) setOwner owner (_this select 1 select 0);
};
};