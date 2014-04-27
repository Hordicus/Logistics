#include "macro.sqf"

private ['_class', '_cfg', '_name'];
_class = [_this, 0, "", [""]] call BIS_fnc_param;
_name = "";

_cfg = _class call LOG_fnc_config;

if ( count _cfg > 0 ) then {
	if ( count _cfg > CONFIG_INDEX_OVERRIDENAME && {_cfg select CONFIG_INDEX_OVERRIDENAME != ""} ) then {
		_name = _cfg select CONFIG_INDEX_OVERRIDENAME;
	}
	else {
		_name = getText ( configFile >> "CfgVehicles" >> _class >> "displayName" );
	};
};

_name