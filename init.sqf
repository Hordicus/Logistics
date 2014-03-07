LOG_currentObject = objNull;
LOG_keyBindID = -1;

LOG_pos_maxDistanceFromPlayer = 5;
LOG_pos_minDistanceFromPlayer = 1;

LOG_pos_maxOffsetHeight = 1;
LOG_pos_minOffsetHeight = -1;

LOG_pos_maxCenterFromPlayer = 1;
LOG_pos_minCenterFromPlayer = -1;

[] call LOG_fnc_resetActionConditions;

// Monitor cursorTarget.
// Doing checking in addAction will run code every frame.
player call LOG_fnc_addPlayerActions;
while {true} do {
	_cursorTarget = cursorTarget;
	LOG_cursorTarget_moveable = objNull;
	LOG_action_liftVehicle = objNull;
	LOG_action_towVehicle = objNull;
	LOG_action_isDriver = (vehicle player) != player && driver vehicle player == player;
	_veh = vehicle player;
	
	if ( _veh == player ) then {
		// Things to check when not in a vehicle
		if (
		_cursorTarget getVariable ['LOG_moveable', false ]
		&& { [_cursorTarget, player] call LOG_fnc_distanceFromObject < 5 } // Do quick distance check
		&& { _cursorTarget in (5 call LOG_fnc_getPointerObject) } // More accurate distance check
		) then {
			LOG_cursorTarget_moveable = _cursorTarget;
		};
	}
	else {
		// Things to check when in a vehicle

		_towedVeh = (_veh getVariable ['LOG_towedObject', objNull]);
		if ( LOG_action_isDriver ) then {
			if ( isNull _towedVeh ) then {
				// Is driver and not towing a vehicle, look for vehicles to tow/lift
				_vehConfig = (typeOf _veh) call LOG_fnc_config;
				if ( count _vehConfig > 0 && isNull (_veh getVariable ['LOG_towedTo', objNull]) ) then {
					if ( _veh isKindOf "Helicopter" && (getPosATL _veh) select 2 <= 100 ) then {
						_vehPos = getPosASL _veh;
						_vehPosLess10 = [_vehPos select 0, _vehPos select 1, (_vehPos select 2)-10];
						
						_objectsBelow = (lineIntersectsWith [_vehPos, _vehPosLess10]) + (ASLtoATL _vehPos nearEntities 3);
						_vehMatch = objNull;
						
						{
							_cfg = (typeOf _x) call LOG_fnc_config;
							if ( count _cfg > 0 && {(_vehConfig select 3) >= (_cfg select 2)} && isNull (_x getVariable ['LOG_towedObject', objNull]) ) exitwith {
								_vehMatch = _x;
							};

						} count _objectsBelow;

						['lift', format['Lift %1', getText (configFile >> "CfgVehicles" >> typeOf _vehMatch >> "displayName")]] call LOG_fnc_renameAction;
						LOG_action_liftVehicle = _vehMatch;
					}
					else { if ( _veh isKindOf "Car" ) then {
						_vehSize = _veh call LOG_fnc_objectSize;
						_vehPos = getPosATL _veh;
						_vehPos set [2, 1];
						_vehPosBehind = [_vehPos, 2 + ((_vehSize select 1)/2), (getDir vehicle player)-180] call BIS_fnc_relPos;
						_vehMatch = objNull;
						
						_objectsBehind = (lineIntersectsWith [ATLtoASL _vehPos, ATLtoASL _vehPosBehind]) - [player, _veh];

						{
							_cfg = (typeOf _x) call LOG_fnc_config;
							if ( count _cfg > 0 && {(_vehConfig select 3) >= (_cfg select 2)} && isNull (_x getVariable ['LOG_towedObject', objNull]) ) exitwith {
								_vehMatch = _x;
							};
							
						} count _objectsBehind;
						
						['tow', format['Tow %1', getText (configFile >> "CfgVehicles" >> typeOf _vehMatch >> "displayName")]] call LOG_fnc_renameAction;
						LOG_action_towVehicle = _vehMatch;
					}};
				};
			}
			else {
				// Make sure we aren't towing while being towed
				if ( ! isNull (_veh getVariable ['LOG_towedTo', objNull]) ) then {
					[_veh getVariable ['LOG_towedTo', objNull], _veh] call LOG_fnc_releaseTowedObject;
				};
			
				// Update release text
				if ( !isNull _towedVeh ) then {
					['release', format['Release %1', getText (configFile >> "CfgVehicles" >> typeOf _towedVeh >> "displayName")]] call LOG_fnc_renameAction;
				};
			};
		};
	};

	sleep 0.1;
};