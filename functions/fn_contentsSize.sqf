/*
	Description:
	Returns the storage capacity for a type of object
	
	Parameter(s):
	_type - Type of object to check
	
	Returns:
	Size of object
*/

private ['_type', '_cfg', '_size'];
_type = [_this, 0, "", [""]] call BIS_fnc_param;
_cfg = _type call LOG_fnc_config;
_size = 0;

if ( count _cfg > 0 ) then {
	_size = _cfg select 1;
};

_size