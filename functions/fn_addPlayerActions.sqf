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
	"move",
	"Move Object",
	{ LOG_cursorTarget_moveable call LOG_fnc_pickupObject },
	_basePriority,
	true,
	"cursorTarget == LOG_cursorTarget_moveable && isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"enable_keybinds",
	"Enable Keybinds",
	LOG_fnc_enableKeybinds,
	_basePriority-1,
	true,
	"!isNull LOG_currentObject && LOG_keyBindID == -1"
]];

_actions set [count _actions, [
	"disable_keybinds",
	"Disable Keybinds",
	LOG_fnc_disableKeybinds,
	_basePriority-1,
	true,
	"!isNull LOG_currentObject && LOG_keyBindID > -1"
]];

_actions set [count _actions, [
	"release_object",
	"Release Object",
	{ [] call LOG_fnc_releaseObject },
	_basePriority+10,
	true,
	"!isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"rotate",
	"Rotate Object",
	{ LOG_action_showRotateOptions = true; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && !LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate45",
	"Rotate 45",
	{ [nil, nil, nil, LOG_pos_direction + 45] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate90",
	"Rotate 90",
	{ [nil, nil, nil, LOG_pos_direction + 90] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate180",
	"Rotate 180",
	{ [nil, nil, nil, LOG_pos_direction + 180] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate_reset",
	"Reset Rotation",
	{ [nil, nil, nil, 0] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate_hide",
	"Hide Rotation Options",
	{ LOG_action_showRotateOptions = false; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];


_actions set [count _actions, [
	"pos_object",
	"Position Object",
	{ LOG_action_showPosOptions = true; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && !LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"match_terrain",
	"Match terrain angle",
	{
		LOG_action_matchTerrain = true;
		["matchTerrain", "onEachFrame", {
			[LOG_currentObject] call LOG_fnc_matchTerrain;
		}] call BIS_fnc_addStackedEventHandler;
	},
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && !LOG_action_matchTerrain"
]];

_actions set [count _actions, [
	"match_terrain_stop",
	"Stop Match terrain angle",
	{
		LOG_action_matchTerrain = false;
		["matchTerrain", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
		LOG_currentObject setVectorUp [0,0,1];
	},
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_action_matchTerrain"
]];

_actions set [count _actions, [
	"pos_forward",
	"Move forward 0.5m",
	{ [LOG_pos_distanceFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer < 5"
]];

_actions set [count _actions, [
	"pos_back",
	"Move back 0.5m",
	{ [LOG_pos_distanceFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer > 1"
]];

_actions set [count _actions, [
	"pos_down",
	"Move down 0.1m",
	{ [nil, LOG_pos_offsetHeight - 0.1 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight > -1"
]];

_actions set [count _actions, [
	"pos_up",
	"Move up 0.1m",
	{ [nil, LOG_pos_offsetHeight + 0.1 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight < 1"
]];

_actions set [count _actions, [
	"pos_left",
	"Move left 0.5m",
	{ [nil, nil, LOG_pos_centerFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer > -1"
]];

_actions set [count _actions, [
	"pos_right",
	"Move right 0.5m",
	{ [nil, nil, LOG_pos_centerFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer < 1"
]];

_actions set [count _actions, [
	"pos_reset",
	"Reset Position",
	{ [LOG_currentObject] call LOG_fnc_pickupObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"pos_hide",
	"Hide Positioning Options",
	{ LOG_action_showPosOptions = false; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"lift",
	"Lift Vehicle",
	{
		if ( [LOG_action_liftVehicle, vehicle player] call LOG_fnc_isTowable ) then {
			[vehicle player, LOG_action_liftVehicle, false] call LOG_fnc_towVehicle;
		}
		else {
			hint "You can't lift that with this helicopter";
		};
	},
	_basePriority,
	true,
	"!isNull LOG_action_liftVehicle"
]];

_actions set [count _actions, [
	"release",
	"Release Vehicle",
	{ [vehicle player] call LOG_fnc_releaseTowedObject },
	_basePriority+10,
	true,
	"LOG_action_isDriver && !isNull ((vehicle player) getVariable ['LOG_towedObject', objNull])"
]];

_actions set [count _actions, [
	"tow",
	"Tow Vehicle",
	{
		if ( [LOG_action_towVehicle, vehicle player] call LOG_fnc_isTowable ) then {
			[vehicle player, LOG_action_towVehicle, true] call LOG_fnc_towVehicle;
		}
		else {
			hint "You can't tow that with this vehicle";
		};
	},
	_basePriority,
	true,
	"!isNull LOG_action_towVehicle"
]];

_actions set [count _actions, [
	"show_contents",
	"Show Contents",
	{ [LOG_action_showContents] call LOG_fnc_showContents; },
	_basePriority,
	true,
	"!isNull LOG_action_showContents && isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"load_object",
	"Load Object",
	{
		if ( [LOG_action_showContents, LOG_currentObject] call LOG_fnc_hasRoom ) then {
			[LOG_currentObject, LOG_action_showContents, true] call LOG_fnc_loadInObject;
		}
		else {
			hint "The container does not have room for that object";
		};
	},
	_basePriority,
	true,
	"!isNull LOG_action_showContents && !isNull LOG_currentObject && LOG_currentObject != LOG_action_showContents"
]];

_ids = [];
{
	_ids set [count _ids, [_x select 0, _player addAction [
		_x select 1,
		_x select 2,
		nil,
		_x select 3,
		false,
		_x select 4,
		"",
		_x select 5
	]]];
} forEach _actions;

LOG_actionIds = _ids;

_ids