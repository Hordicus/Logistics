LOG_actions = missionNamespace getVariable ['LOG_actions', []];
LOG_actionsIds = missionNamespace getVariable ['LOG_actionsIds', []];
LOG_actionsVehicleIds = missionNamespace getVariable ['LOG_actionsIds', []];

private ['_id'];
_id = count LOG_actions;

private ['_title', '_code', '_arguments', '_priority', '_showWindow', '_hideOnUse', '_shortcut', '_condition', '_id', '_obj'];
_title      = [_this, 0, "", [""]] call BL_fnc_param;
_code       = [_this, 1, {}, [{}]] call BL_fnc_param;
_arguments  = [_this, 2, [], [[]]] call BL_fnc_param;
_priority   = [_this, 3, 1.5, [0]] call BL_fnc_param;
_showWindow = [_this, 4, true, [true]] call BL_fnc_param;
_hideOnUse  = [_this, 5, true, [true]] call BL_fnc_param;
_shortcut   = [_this, 6, "", [""]] call BL_fnc_param;
_condition  = [_this, 7, "", [""]] call BL_fnc_param;
_id         = [_this, 8, _id, [0]] call BL_fnc_param;

LOG_actions set [_id, [
	_title,
	_code,
	_arguments,
	_priority,
	_showWindow,
	_hideOnUse,
	_shortcut,
	_condition
]];

LOG_actionsIds set [_id, player addAction [
	_title,
	"logistics\functions\fn_addActionHandler.sqf",
	_id,
	_priority,
	_showWindow,
	_hideOnUse,
	_shortcut,
	_condition
]];

if !( (vehicle player) isKindOf "Man" ) then {
	LOG_actionsVehicleIds set [_id, (vehicle player) addAction [
		_title,
		"logistics\functions\fn_addActionHandler.sqf",
		_id,
		_priority,
		_showWindow,
		_hideOnUse,
		_shortcut,
		_condition
	]];
}
else {
	LOG_actionsVehicleIds set [_id, -1];
};

_id