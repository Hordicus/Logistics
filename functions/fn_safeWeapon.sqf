[] spawn {
	private ['_eh'];	
	_eh = player addEventHandler ['fired', {
		// Delete bullet
		deleteVehicle (_this select 6);
		
		// Inform player
		titleText ['Your weapons will not work while moving an object', 'PLAIN', 0];
		titleFadeOut 10;
		
		if (cameraView == "Gunner") then {
			player switchCamera "Internal";
		};
		
		// Lower weapon again
		player action ["WEAPONONBACK", player];
	}];
	
	waitUntil { isNull LOG_currentObject };	
	player removeEventHandler ['fired', _eh];
};