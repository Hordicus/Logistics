private ['_object'];
_object = [_this, 0, objNull, [objNull]] call BL_fnc_param;

if ( [_object] call LOG_fnc_isMoveable ) then {
	if ( !isNil "LOG_currentObject" ) then {
		detach LOG_currentObject;
	};

	LOG_currentObject = _object;

	// Variables to remember current settings in.
	// Doubles as default values.
	LOG_pos_distanceFromPlayer = 2.5;
	LOG_pos_offsetHeight = 0;
	LOG_pos_centerFromPlayer = 0;
	LOG_pos_direction = 0;
	
	LOG_PVAR_setOwner = [player, LOG_currentObject];
	publicVariableServer "LOG_PVAR_setOwner";
	
	[] spawn {
		waitUntil {local LOG_currentObject};
		[] call LOG_fnc_positionHeldObject;
		[] call LOG_fnc_safeWeapon;
	};	
	
	[] spawn {
		while { !isNull LOG_currentObject } do {
			if ( vehicle player != player ) then {
				[] call LOG_fnc_releaseObject;
			};
			
			sleep 0.5;
		};
	};
};