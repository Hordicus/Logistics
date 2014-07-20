/*
	Description:
	Detaches held object.
*/

// beforeReleaseObject can not override default action if the player is dead.
if ( ['beforeReleaseObject', [LOG_currentObject]] call LOG_fnc_triggerEvent || !alive player ) then {
	player reveal LOG_currentObject;
	detach LOG_currentObject;

	LOG_currentObject setVelocity [0,0,0];
	LOG_currentObject = objNull;

	[] call LOG_fnc_resetActionConditions;
	
	LOG_currentObject
};