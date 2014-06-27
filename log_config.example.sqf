private ['_config', '_class', '_result', '_classes'];
_config = [
	// Moving backwards and forwards
	["maxDistanceFromPlayer", 5],
	["minDistanceFromPlayer", 1],

	// Moving up and down
	["maxOffsetHeight", 1],
	["minOffsetHeight", -1],

	// Moving left and right
	["maxCenterFromPlayer", 1],
	["minCenterFromPlayer", -1],
	
	// Change if you need to handle the creation/deletion of objects a special way
	["createVehicle", { createVehicle [_this select 0, _this select 1, [], 0, "CAN_COLLIDE"]; }],
	["deleteVehicle", { deleteVehicle (_this select 0); }],

	// [class, capacity, size, weight, max towing capacity]
	["MRAP_01_base_F",         50,	-1,		5000,	5000],
	["B_Heli_Transport_01_F",  20,	-1,		12000,	8000],
	["Land_Cargo40_blue_F",    500,	-1,		6000,	0],
	["Land_Cargo40_red_F",     500,	10000,	6000,	0],
	["Land_CargoBox_V1_F",     250,	10000,	4000,	0],
	["C_Hatchback_01_sport_F", 20,	10000,	4000,	5000],
	
	//	Building Materials
	["Land_CinderBlocks_F",      0,	50,		-1,	0],
	["Land_CncBarrier_F",        0,	50,		-1,	0],
	["Land_CncWall1_F",          0,	50,		-1,	0],
	["Land_Timbers_F",           0,	50,		-1,	0],
	["Land_A_Castle_Bergfrit",   0,	200,	-1,	0],
	["Land_A_Castle_Stairs_A",   0,	100,	-1,	0],
	["Land_Ind_SawMillPen",      0,	100,	-1,	0],
	["Land_Scaffolding_F",       0,	50,		-1,	0],
	["Land_TableDesk_F",         0,	25,		-1,	0],
	["Land_BagBunker_Large_F",   0,	50,		-1,	0],
	["Land_BagBunker_Tower_F",   0,	50,		-1,	0],
	["BlockConcrete_F",          0,	50,		-1,	0],
	["Land_RampConcrete_F",      0,	50,		-1,	0],
	["Land_RampConcreteHigh_F",  0,	50,		-1,	0],
	["Land_CncBarrierMedium4_F", 0,	50,		-1,	0],
	["Land_CncWall4_F",          0,	50,		-1,	0],
	["Land_BagBunker_Small_F",   0,	25,		-1,	0],
	["Land_BagFence_Long_F",     0,	25,		-1,	0],
	["Land_BagFence_Round_F",    0,	25,		-1,	0],
	["Box_IND_Ammo_F",           0,	25,		-1,	0]
];

if ( isNil "LOG_configLookup" ) then {
	_classes = [];
	
	{
		_classes set [_forEachIndex, _x select 0];
	} forEach _config;
	
	LOG_configLookup = compile format['private["_index", "_result", "_config"]; _config = %1; _index = %2 find _this; if ( _index > -1 ) then { _result = (_config select _index); } else { _result = []; }; _result', _config, _classes];
};

_class = [_this, 0, false, [""]] call BL_fnc_param;

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