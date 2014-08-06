private ['_id', '_text', '_realId', '_action'];
_id = [_this, 0, -1, [0]] call BL_fnc_param;
_text = [_this, 1, "", [""]] call BL_fnc_param;

_realId = LOG_actionsIds select _id;
_action = LOG_actions select _id;

if !( (_action select 0) == _text ) then {
	player removeAction _realId;
	
	if ( vehicle player != player ) then {
		private ['_actions'];
		_actions = (vehicle player) getVariable ['vehicleActionIds', []];
		(vehicle player) removeAction (_actions select _id);
	};
	
	
	_action set [0, _text];
	_action set [8, _id];

	_action call LOG_fnc_addAction;
};