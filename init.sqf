if ( !hasInterface ) exitwith{};

LOG_currentObject = objNull;
LOG_keyBindID = -1;

LOG_pos_maxDistanceFromPlayer = ("maxDistanceFromPlayer" call LOG_fnc_config) select 1;
LOG_pos_minDistanceFromPlayer = ("minDistanceFromPlayer" call LOG_fnc_config) select 1;

LOG_pos_maxOffsetHeight = ("maxOffsetHeight" call LOG_fnc_config) select 1;
LOG_pos_minOffsetHeight = ("minOffsetHeight" call LOG_fnc_config) select 1;

LOG_pos_maxCenterFromPlayer = ("maxCenterFromPlayer" call LOG_fnc_config) select 1;
LOG_pos_minCenterFromPlayer = ("minCenterFromPlayer" call LOG_fnc_config) select 1;

LOG_showingContentsOf = objNull;

LOG_PVAR_UNLOADITEM_RES = objNull;
LOG_PVAR_SETVELOCITY = objNull;

LOG_eventHandlers = [];

[] call LOG_fnc_resetActionConditions;

"LOG_PVAR_SETVELOCITY" addPublicVariableEventHandler {
	private ["_veh","_velocity"];
	_veh      = [_this select 1, 0, objNull, [objNull]] call BIS_fnc_param;
	_velocity = [_this select 1, 1, [0,0,0], [[]], [3]] call BIS_fnc_param;
	
	_veh setVelocity _velocity;
};

[] spawn {
waitUntil {!isNull player && player == player};
waitUntil{!isNil "BIS_fnc_init"};
waitUntil {!(isNull (findDisplay 46))};

player call LOG_fnc_addPlayerActions;
player addEventHandler ['respawn', {
	[] call LOG_fnc_resetActionConditions;
	player call LOG_fnc_addPlayerActions;
}];

player addEventHandler ['killed', {
	if ( !isNull LOG_currentObject ) then {
		[] call LOG_fnc_releaseObject;
	};
}];
_setVars = [];
while {true} do {
	_cursorTarget = cursorTarget;
	_setVars = [];
	LOG_action_isDriver = (vehicle player) != player && driver vehicle player == player;

	_veh = vehicle player;
	
	if ( _veh == player ) then {
		// Things to check when not in a vehicle
		if (
			[_cursorTarget, player] call LOG_fnc_distanceFromObject < 5 // Do quick distance check
			&& { _cursorTarget in (5 call LOG_fnc_getPointerObject) } // More accurate distance check
		) then {
			if ( _cursorTarget call LOG_fnc_isMoveable ) then {
				LOG_cursorTarget_moveable = _cursorTarget;
				_setVars set [count _setVars, "LOG_cursorTarget_moveable"];
			};
			
			if ( ((typeOf _cursorTarget) call LOG_fnc_containerSize) > 0 ) then {
				LOG_action_showContents = _cursorTarget;
				_setVars set [count _setVars, "LOG_action_showContents"];
				_containerName = getText (configFile >> "CfgVehicles" >> typeOf _cursorTarget >> "displayName");
				['show_contents', format['Show %1 Contents', _containerName]] call LOG_fnc_renameAction;

				if ( !isNull LOG_currentObject ) then {
					_heldName = getText (configFile >> "CfgVehicles" >> typeOf LOG_currentObject >> "displayName");
					_text = format['Load %1 into %2', _heldName, _containerName];
					
					if !( [_cursorTarget, LOG_currentObject] call LOG_fnc_hasRoom ) then {
						_text = format['<t color="#FF0000">%1</t>', _text];
					};
					
					['load_object', _text] call LOG_fnc_renameAction;
				};
			};
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
					if ( _veh isKindOf "Air" ) then {
						_vehPos = _veh modelToWorld (getCenterOfMass _veh);
						_vehPosLess10 = [_vehPos select 0, _vehPos select 1, (_vehPos select 2)-10];
						_objectsBelow = (lineIntersectsWith [ATLtoASL _vehPos, ATLtoASL _vehPosLess10, objNull, objNull, true]) - [_veh] - allUnits;
						
						if ( count _objectsBelow > 0 && {[_objectsBelow select (count _objectsBelow-1)] call LOG_fnc_isTowable} ) then {
							LOG_action_liftVehicle = _objectsBelow select (count _objectsBelow-1);
							_setVars set [count _setVars, "LOG_action_liftVehicle"];
							
							_text = format['Lift %1', getText (configFile >> "CfgVehicles" >> typeOf LOG_action_liftVehicle >> "displayName")];
							if ( [LOG_action_liftVehicle, _veh] call LOG_fnc_isTowable ) then {
								['lift', _text] call LOG_fnc_renameAction;
							}
							else {
								['lift', format['<t color="#FF0000">%1</t>', _text]] call LOG_fnc_renameAction;
							};
						};
					}
					else { if ( _veh isKindOf "LandVehicle" ) then {
						_vehDim = _veh call LOG_fnc_objectDemensions;
						_vehPos = getPosATL _veh;
						_vehPos set [2, 1];
						_vehPosBehind = [_vehPos, 2 + ((_vehDim select 1)/2), (getDir vehicle player)-180] call BIS_fnc_relPos;
						
						_objectsBehind = (lineIntersectsWith [ATLtoASL _vehPos, ATLtoASL _vehPosBehind, objNull, objNull, true]) - [_veh] - allUnits;
					
						if ( count _objectsBehind > 0 && {[_objectsBehind select (count _objectsBehind-1)] call LOG_fnc_isTowable} ) then {
							LOG_action_towVehicle = _objectsBehind select (count _objectsBehind-1);
							_setVars set [count _setVars, "LOG_action_towVehicle"];							

							_text = format['Tow %1', getText (configFile >> "CfgVehicles" >> typeOf LOG_action_towVehicle >> "displayName")];							
							if ( [LOG_action_towVehicle, _veh] call LOG_fnc_isTowable ) then {
								['tow', _text] call LOG_fnc_renameAction;
							}
							else {
								['tow', format['<t color="#FF0000">%1</t>', _text]] call LOG_fnc_renameAction;
							};
						};
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
	
	
	// Reset action vars to default values if
	// they weren't set. Keeps things from flashing on/off in
	// the action menu.
	if !( "LOG_cursorTarget_moveable" in _setVars ) then {
		LOG_cursorTarget_moveable = objNull;
	};
	
	if !( "LOG_action_liftVehicle" in _setVars ) then {
		LOG_action_liftVehicle = objNull;
	};
	
	if !( "LOG_action_towVehicle" in _setVars ) then {
		LOG_action_towVehicle = objNull;
	};
	
	if !( "LOG_action_showContents" in _setVars ) then {
		LOG_action_showContents = objNull;
	};

	sleep 0.1;
};
};