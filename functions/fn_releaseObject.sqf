/*
	Description:
	Detaches held object.
*/

// beforeReleaseObject can not override default action if the player is dead.
if ( ['beforeReleaseObject', [LOG_currentObject]] call LOG_fnc_triggerEvent || !alive player ) then {
	private ['_dir', '_vUp'];
	_dir = vectorDir LOG_currentObject;
	_vUp = vectorUp LOG_currentObject;
	detach LOG_currentObject;

	LOG_PVAR_SETVECTORDIRANDUP = [LOG_currentObject, [_dir, _vUp]];
	publicVariableServer "LOG_PVAR_SETVECTORDIRANDUP";
	
	LOG_currentObject setVelocity [0,0,0];
	LOG_currentObject = objNull;

	[] call LOG_fnc_resetActionConditions;
	
	LOG_currentObject
};