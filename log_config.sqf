private ['_config', '_class', '_result'];
_config = [
	// [class, capacity, weight, max towing capacity, moveable]
	["B_MRAP_01_F", 50, 5000, 10000, false],
	["B_Heli_Transport_01_F", 20, 12000, 8000, false],
	["Land_Cargo40_blue_F", 100, 500, 0, true]
];

_class = [_this, 0, "", [""]] call BIS_fnc_param;

if ( _class != "" ) then {
	_result = [];
	
	{
		if ( _class == _x select 0 ) exitwith {
			_result = _x;
		};
	} count _config;
	
	_result
}
else {
	_config
};