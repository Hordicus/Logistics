/*
	Description:
	Adds KeyDown event handler to main display
	that implements Buldozer binds.
	
	Parameter(s):
	None
*/

LOG_keyBindID = (findDisplay 46) displayAddEventHandler ["KeyDown", "_this call " + str {
	if ( isNull LOG_currentObject ) exitwith{};
	_key = _this select 1;

	_handled = switch true do {
		case (_key in actionKeys "BuldUp" && LOG_pos_offsetHeight < LOG_pos_maxOffsetHeight ): {
			[nil, LOG_pos_offsetHeight + 0.1] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "BuldDown" && LOG_pos_offsetHeight > LOG_pos_minOffsetHeight ): {
			[nil, LOG_pos_offsetHeight - 0.1] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "BuldLeft" && LOG_pos_centerFromPlayer > LOG_pos_minCenterFromPlayer ): {
			[nil, nil, LOG_pos_centerFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "BuldRight" && LOG_pos_centerFromPlayer < LOG_pos_maxCenterFromPlayer ): {
			[nil, nil, LOG_pos_centerFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "BuldForward" && LOG_pos_distanceFromPlayer < LOG_pos_maxDistanceFromPlayer ): {
			[LOG_pos_distanceFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "BuldBack" && LOG_pos_distanceFromPlayer > LOG_pos_minDistanceFromPlayer ): {
			[LOG_pos_distanceFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "HeliRudderLeft"): {
			[nil, nil, nil, LOG_pos_direction - 45] call LOG_fnc_positionHeldObject;
			true
		};
		
		case (_key in actionKeys "HeliRudderRight"): {
			[nil, nil, nil, LOG_pos_direction + 45] call LOG_fnc_positionHeldObject;
			true
		};
		
		default {
			false
		};
	};
	
	_handled
}];