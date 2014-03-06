/*
	Description:
	Detaches held object. Just a nicety. 
*/

detach LOG_currentObject;
LOG_currentObject setVelocity [0,0,0];
LOG_currentObject = objNull;

[] call LOG_fnc_resetActionConditions;

LOG_currentObject