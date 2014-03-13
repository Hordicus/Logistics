private ['_config', '_class', '_result', '_classes'];
_config = [
	// [class, capacity, weight, max towing capacity, moveable, towable]
	["MRAP_01_base_F", 50, 5000, 10000, false, true],
	["B_Heli_Transport_01_F", 20, 12000, 8000, false, false],
	["Land_Cargo40_blue_F", 100, 500, 0, true, false],
	["Land_Cargo40_red_F", 100, 500, 0, true, false],
	["Land_CargoBox_V1_F", 50, 250, 0, true, true],
	["C_Hatchback_01_sport_F", 20, 250, 5000, false, true],
	
	// Building Materials
	["Land_CinderBlocks_F", 0, 50, 0, true, false],
	["Land_CncBarrier_F", 0, 50, 0, true, false],
	["Land_CncWall1_F", 0, 50, 0, true, false],
	["Land_Timbers_F", 0, 50, 0, true, false],
	["Land_A_Castle_Bergfrit", 0, 200, 0, true, false],
	["Land_A_Castle_Stairs_A", 0, 100, 0, true, false],
	["Land_Ind_SawMillPen", 0, 100, 0, true, false],
	["Land_Scaffolding_F", 0, 50, 0, true, false],
	["Land_TableDesk_F", 0, 25, 0, true, false],
	["Land_BagBunker_Large_F", 0, 50, 0, true, false],
	["Land_BagBunker_Tower_F", 0, 50, 0, true, false],
	["BlockConcrete_F", 0, 50, 0, true, false],
	["Land_RampConcrete_F", 0, 50, 0, true, false],
	["Land_RampConcreteHigh_F", 0, 50, 0, true, false],
	["Land_CncBarrierMedium4_F", 0, 50, 0, true, false],
	["Land_CncWall4_F", 0, 50, 0, true, false],
	["Land_BagBunker_Small_F", 0, 25, 0, true, false],
	["Land_BagFence_Long_F", 0, 25, 0, true, false],
	["Land_BagFence_Round_F", 0, 25, 0, true, false],
	["Box_IND_Ammo_F", 0, 25, 0, true, false]
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