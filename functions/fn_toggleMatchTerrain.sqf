LOG_toggleMatchTerrainScript = missionNamespace getVariable ['LOG_toggleMatchTerrainScript', false];

if ( typeName LOG_toggleMatchTerrainScript == "BOOL" ) then {
	LOG_toggleMatchTerrainScript = [] spawn {
		waitUntil { [LOG_currentObject] call LOG_fnc_matchTerrain; isNull LOG_currentObject };
		
		LOG_toggleMatchTerrainScript = false;
	};
}
else {
	terminate LOG_toggleMatchTerrainScript;
	LOG_currentObject setVectorUp [0,0,1];
	LOG_toggleMatchTerrainScript = false;
};