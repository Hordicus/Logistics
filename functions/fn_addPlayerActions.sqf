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
_player = [_this, 0, player, [player]] call BL_fnc_param;
_basePriority = 0;
_actions = [];

_actions set [count _actions, [
	"move",
	"<t color='#ff9c00'><img image='logistics\icons\moveobject.paa' /> Move Object</t>",
	{ LOG_cursorTarget_moveable call LOG_fnc_pickupObject },
	_basePriority,
	true,
	"cursorTarget == LOG_cursorTarget_moveable && isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"enable_keybinds",
	"<t color='#00a3e0'><img image='logistics\icons\enablekb.paa' /> Enable Keybinds</t>",
	LOG_fnc_enableKeybinds,
	_basePriority-1,
	true,
	"!isNull LOG_currentObject && LOG_keyBindID == -1"
]];

_actions set [count _actions, [
	"disable_keybinds",
	"<t color='#00a3e0'><img image='logistics\icons\disablekb.paa' /> Disable Keybinds</t>",
	LOG_fnc_disableKeybinds,
	_basePriority-1,
	true,
	"!isNull LOG_currentObject && LOG_keyBindID > -1"
]];

_actions set [count _actions, [
	"release_object",
	"<t color='#ff9c00'><img image='logistics\icons\releaseobject.paa' /> Release Object</t>",
	{ [] call LOG_fnc_releaseObject },
	_basePriority+10,
	true,
	"!isNull LOG_currentObject"
]];

_actions set [count _actions, [
	"rotate",
	"<t color='#d45500'><img image='logistics\icons\rotateobject.paa' /> Rotate Options</t>",
	{ LOG_action_showRotateOptions = true; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && !LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate45",
	"<t color='#d45500'>Rotate 45</t>",
	{ [nil, nil, nil, LOG_pos_direction + 45] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate90",
	"<t color='#d45500'>Rotate 90</t>",
	{ [nil, nil, nil, LOG_pos_direction + 90] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate180",
	"<t color='#d45500'>Rotate 180</t>",
	{ [nil, nil, nil, LOG_pos_direction + 180] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate_reset",
	"<t color='#d45500'>Reset Rotation</t>",
	{ [nil, nil, nil, 0] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];

_actions set [count _actions, [
	"rotate_hide",
	"<t color='#d45500'>Hide Rotation Options</t>",
	{ LOG_action_showRotateOptions = false; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showRotateOptions"
]];


_actions set [count _actions, [
	"pos_object",
	"<t color='#d48200'><img image='logistics\icons\positionoptions.paa' /> Position Options</t>",
	{ LOG_action_showPosOptions = true; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && !LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"match_terrain",
	"<t color='#d48200'><img image='logistics\icons\terrainon.paa' /> Match terrain angle</t>",
	{
		LOG_action_matchTerrain = true;
		[] call LOG_fnc_toggleMatchTerrain;
	},
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && !LOG_action_matchTerrain"
]];

_actions set [count _actions, [
	"match_terrain_stop",
	"<t color='#d48200'><img image='logistics\icons\terrainoff.paa' /> Stop Match terrain angle</t>",
	{
		LOG_action_matchTerrain = false;
		LOG_currentObject setVectorUp [0,0,1];
		[] call LOG_fnc_toggleMatchTerrain;
	},
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_action_matchTerrain"
]];

_actions set [count _actions, [
	"pos_forward",
	"<t color='#d48200'>Move forward 0.5m</t>",
	{ [LOG_pos_distanceFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer < 5"
]];

_actions set [count _actions, [
	"pos_back",
	"<t color='#d48200'>Move back 0.5m</t>",
	{ [LOG_pos_distanceFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_distanceFromPlayer > 1"
]];

_actions set [count _actions, [
	"pos_down",
	"<t color='#d48200'>Move down 0.1m</t>",
	{ [nil, LOG_pos_offsetHeight - 0.1 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight > -1"
]];

_actions set [count _actions, [
	"pos_up",
	"<t color='#d48200'>Move up 0.1m</t>",
	{ [nil, LOG_pos_offsetHeight + 0.1 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_offsetHeight < 1"
]];

_actions set [count _actions, [
	"pos_left",
	"<t color='#d48200'>Move left 0.5m</t>",
	{ [nil, nil, LOG_pos_centerFromPlayer - 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer > -1"
]];

_actions set [count _actions, [
	"pos_right",
	"<t color='#d48200'>Move right 0.5m</t>",
	{ [nil, nil, LOG_pos_centerFromPlayer + 0.5 ] call LOG_fnc_positionHeldObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions && LOG_pos_centerFromPlayer < 1"
]];

_actions set [count _actions, [
	"pos_reset",
	"<t color='#d48200'>Reset Position</t>",
	{ [LOG_currentObject] call LOG_fnc_pickupObject },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
]];

_actions set [count _actions, [
	"pos_hide",
	"<t color='#d48200'>Hide Positioning Options</t>",
	{ LOG_action_showPosOptions = false; },
	_basePriority,
	false,
	"!isNull LOG_currentObject && LOG_action_showPosOptions"
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
		_error = [] call {
			if !(isNull (LOG_action_towVehicle getVariable ['LOG_towedObject', objNull])) exitwith {
				"That vehicle is towing an object"
			};
			
			if !(isNull ((vehicle player) getVariable ['LOG_towedTo', objNull])) exitwith {
				"You can't tow a vehicle while you are being towed"
			};
			
			if !(isNull (LOG_action_towVehicle getVariable ['LOG_towedTo', objNull])) exitwith {
				"That vehicle is already being towed"
			};

			if !([LOG_action_towVehicle, vehicle player] call LOG_fnc_isTowable) exitwith {
				"You can't tow that with this vehicle"
			};
			
			""
		};
		
		if ( _error == "" ) then {
			[vehicle player, LOG_action_towVehicle, !((vehicle player) isKindOf 'Air')] call LOG_fnc_towVehicle;
		}
		else {
			hint _error;
		};
	},
	_basePriority+10,
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
		private ['_obj'];
		_obj = LOG_currentObject;
		if ( isNull _obj ) then {
			_obj = LOG_action_loadObject;
		};
		
		if ( [LOG_action_showContents, _obj] call LOG_fnc_hasRoom ) then {
			[_obj, LOG_action_showContents, true] call LOG_fnc_loadInObject;
		}
		else {
			hint "The container does not have room for that object";
		};
	},
	_basePriority,
	true,
	"!isNull LOG_action_showContents && ((!isNull LOG_currentObject && LOG_currentObject != LOG_action_showContents) || (!isNull LOG_action_loadObject && LOG_action_loadObject != LOG_action_showContents && LOG_action_loadObject distance LOG_action_showContents < 10 ))"
]];

_actions set [count _actions, [
	"select_load_object",
	"<t color='#c7c500'><img image='logistics\icons\load.paa' /> Load Object</t>",
	{LOG_action_loadObject = LOG_cursorTarget_moveable},
	_basePriority+10,
	true,
	"!isNull LOG_cursorTarget_moveable && isNull LOG_currentObject"
]];

_ids = [];

{
	_ids set [count _ids, [_x select 0, [
		_x select 1,
		_x select 2,
		nil,
		_x select 3,
		false,
		_x select 4,
		"",
		_x select 5
	] call LOG_fnc_addAction]];
} forEach _actions;

LOG_actionNameIds = _ids;

_ids