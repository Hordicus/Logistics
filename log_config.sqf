private ['_config', '_class', '_result', '_classes'];
_config = [
	// [class, capacity, size, weight, max towing capacity, moveable]
	["MRAP_01_base_F",         50,	-1,	5000,	10000,	false],
	["B_Heli_Transport_01_F",  20,	-1,	12000,	8000,	false],
	["Land_Cargo40_blue_F",    500,	-1,	500,	0,		true],
	["Land_Cargo40_red_F",     500,	-1,	500,	0,		true],
	["Land_CargoBox_V1_F",     250,	-1,	250,	0,		true],
	["C_Hatchback_01_sport_F", 20,	-1,	250,	5000,	false],
	
	//	Building Materials
	["Land_CinderBlocks_F",      0,	50,		-1,	0,	true],
	["Land_CncBarrier_F",        0,	50,		-1,	0,	true],
	["Land_CncWall1_F",          0,	50,		-1,	0,	true],
	["Land_Timbers_F",           0,	50,		-1,	0,	true],
	["Land_A_Castle_Bergfrit",   0,	200,	-1,	0,	true],
	["Land_A_Castle_Stairs_A",   0,	100,	-1,	0,	true],
	["Land_Ind_SawMillPen",      0,	100,	-1,	0,	true],
	["Land_Scaffolding_F",       0,	50,		-1,	0,	true],
	["Land_TableDesk_F",         0,	25,		-1,	0,	true],
	["Land_BagBunker_Large_F",   0,	50,		-1,	0,	true],
	["Land_BagBunker_Tower_F",   0,	50,		-1,	0,	true],
	["BlockConcrete_F",          0,	50,		-1,	0,	true],
	["Land_RampConcrete_F",      0,	50,		-1,	0,	true],
	["Land_RampConcreteHigh_F",  0,	50,		-1,	0,	true],
	["Land_CncBarrierMedium4_F", 0,	50,		-1,	0,	true],
	["Land_CncWall4_F",          0,	50,		-1,	0,	true],
	["Land_BagBunker_Small_F",   0,	25,		-1,	0,	true],
	["Land_BagFence_Long_F",     0,	25,		-1,	0,	true],
	["Land_BagFence_Round_F",    0,	25,		-1,	0,	true],
	["Box_IND_Ammo_F",           0,	25,		-1,	0,	true]
];

if ( isNil "LOG_configLookup" ) then {
	_classes = [];
	
	{
		_classes set [_forEachIndex, _x select 0];
	} forEach _config;
	
	LOG_configLookup = compileFinal format['private["_index", "_result", "_config"]; _config = %1; _index = %2 find _this; if ( _index > -1 ) then { _result = (_config select _index); } else { _result = []; }; _result', _config, _classes];
};

_class = [_this, 0, false, [""]] call BIS_fnc_param;

if ( typeName _class == "STRING" ) then {
	_result = _class call LOG_configLookup;
	if ( count _result == 0 ) then {
		// No match for exact class. Check parents.
		_parents = [];
		_parent = _class;
		
		while { _parent != "All" && count _result == 0} do {
			_parent = configName inheritsFrom (configFile >> "CfgVehicles" >> _parent);
			_parents set [count _parents, _parent];
			_result = _parent call LOG_configLookup
		};
	};
	
	_result
}
else {
	_config
};