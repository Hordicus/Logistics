_player = [_this, 0, player, [player]] call BIS_fnc_param;

_basePriority = 0;

_player addAction [
	"Move Object",
	{ LOG_cursorTarget_moveable call LOG_fnc_pickupObject },
	nil,
	_basePriority,
	false,
	true,
	"",
	"cursorTarget == LOG_cursorTarget_moveable && isNull LOG_currentObject"
];

_player addAction [
	"Enable Keybinds",
	LOG_fnc_enableKeybinds,
	nil,
	_basePriority-1,
	false,
	true,
	"",
	"!isNull LOG_currentObject && LOG_keyBindID == -1"
];

_player addAction [
	"Disable Keybinds",
	LOG_fnc_disableKeybinds,
	nil,
	_basePriority-1,
	false,
	true,
	"",
	"!isNull LOG_currentObject && LOG_keyBindID > -1"
];

_player addAction [
	"Release Object",
	{ [] call LOG_fnc_releaseObject },
	nil,
	_basePriority,
	false,
	true,
	"",
	"!isNull LOG_currentObject"
];

_player addAction [
	"Rotate Object",
	{ LOG_action_showRotateOptions = true; },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && !LOG_action_showRotateOptions"
];

_player addAction [
	"Rotate 45",
	{ [nil, nil, nil, LOG_pos_direction + 45] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
];

_player addAction [
	"Rotate 90",
	{ [nil, nil, nil, LOG_pos_direction + 90] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
];

_player addAction [
	"Rotate 180",
	{ [nil, nil, nil, LOG_pos_direction + 180] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
];

_player addAction [
	"Reset Rotation",
	{ [nil, nil, nil, 0] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
];

_player addAction [
	"Hide Rotation Options",
	{ LOG_action_showRotateOptions = false; },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
];


_player addAction [
	"Position Object",
	{ LOG_action_showPosOptions = true; },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && !LOG_action_showPosOptions"
];

_player addAction [
	"Move forward 0.5m",
	{ [LOG_pos_distanceFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer < 5"
];

_player addAction [
	"Move back 0.5m",
	{ [LOG_pos_distanceFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer > 1"
];

_player addAction [
	"Move down 0.1m",
	{ [nil, LOG_pos_offsetHeight - 0.1 ] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight > -1"
];

_player addAction [
	"Move up 0.1m",
	{ [nil, LOG_pos_offsetHeight + 0.1 ] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight < 1"
];

_player addAction [
	"Move left 0.5m",
	{ [nil, nil, LOG_pos_centerFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer > -1"
];

_player addAction [
	"Move right 0.5m",
	{ [nil, nil, LOG_pos_centerFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer < 1"
];

_player addAction [
	"Reset Position",
	{ [LOG_currentObject] call LOG_fnc_pickupObject },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
];

_player addAction [
	"Hide Positioning Options",
	{ LOG_action_showPosOptions = false; },
	nil,
	_basePriority,
	false,
	false,
	"",
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
];