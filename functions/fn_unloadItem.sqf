private ["_container","_item","_contents","_obj","_object","_mags","_weapons","_items","_i"];

_container = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_item      = [_this, 1, "", [""]] call BIS_fnc_param;

LOG_PVAR_UNLOADITEM = [player, _container, _item];
publicVariableServer "LOG_PVAR_UNLOADITEM";

[] spawn {
	LOG_PVAR_UNLOADITEM_RES = objNull;
	waituntil { !isNull LOG_PVAR_UNLOADITEM_RES };
	LOG_PVAR_UNLOADITEM_RES call LOG_fnc_pickupObject;
};