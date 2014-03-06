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
	
	if (
	_cursorTarget getVariable ['LOG_moveable', false ]
	&& { [_cursorTarget, player] call LOG_fnc_distanceFromObject < 5 } // Do quick distance check
	&& { _cursorTarget in (5 call LOG_fnc_getPointerObject) } // More accurate distance check
	) then {
		LOG_cursorTarget_moveable = _cursorTarget;
	};

	sleep 0.1;
};