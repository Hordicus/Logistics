/*
	Description:
	Adds actions to the player for interacting with
	objects.
	
	Parameter(s):
	_player - Unit to attach actions to
	
	Returns:
	Array - List of ids for actions
*/

private ['_player', '_basePriority', '_actions', '_ids'];
_player = [_this, 0, player, [player]] call BIS_fnc_param;
_basePriority = 0;
_actions = [];

_actions set [count _actions, [
	"Move Object",
	{ LOG_cursorTarget_moveable call LOG_fnc_pickupObject },
	_basePriority,
	true,
	"cursorTarget == LOG_cursorTarget_moveable && isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"Enable Keybinds",
	LOG_fnc_enableKeybinds,
	_basePriority-1,
	true,
	"!isNull LOG_currentObject && LOG_keyBindID == -1"
]];

_actions set [count _actions, [
	"Disable Keybinds",
	LOG_fnc_disableKeybinds,
	_basePriority-1,
	true,
	"!isNull LOG_currentObject && LOG_keyBindID > -1"
]];

_actions set [count _actions, [
	"Release Object",
	{ [] call LOG_fnc_releaseObject },
	_basePriority,
	true,
	"!isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"Rotate Object",
	{ LOG_action_showRotateOptions = true; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && !LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"Rotate 45",
	{ [nil, nil, nil, LOG_pos_direction + 45] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"Rotate 90",
	{ [nil, nil, nil, LOG_pos_direction + 90] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"Rotate 180",
	{ [nil, nil, nil, LOG_pos_direction + 180] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"Reset Rotation",
	{ [nil, nil, nil, 0] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"Hide Rotation Options",
	{ LOG_action_showRotateOptions = false; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];


_actions set [count _actions, [
	"Position Object",
	{ LOG_action_showPosOptions = true; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && !LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"Move forward 0.5m",
	{ [LOG_pos_distanceFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer < 5"
]];

_actions set [count _actions, [
	"Move back 0.5m",
	{ [LOG_pos_distanceFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer > 1"
]];

_actions set [count _actions, [
	"Move down 0.1m",
	{ [nil, LOG_pos_offsetHeight - 0.1 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight > -1"
]];

_actions set [count _actions, [
	"Move up 0.1m",
	{ [nil, LOG_pos_offsetHeight + 0.1 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight < 1"
]];

_actions set [count _actions, [
	"Move left 0.5m",
	{ [nil, nil, LOG_pos_centerFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer > -1"
]];

_actions set [count _actions, [
	"Move right 0.5m",
	{ [nil, nil, LOG_pos_centerFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer < 1"
]];

_actions set [count _actions, [
	"Reset Position",
	{ [LOG_currentObject] call LOG_fnc_pickupObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"Hide Positioning Options",
	{ LOG_action_showPosOptions = false; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
]];

_ids = [];
{
	_ids set [count _ids, _player addAction [
		_x select 0,
		_x select 1,
		nil,
		_x select 2,
		false,
		_x select 3,
		"",
		_x select 4
	]];
} forEach _actions;

_ids