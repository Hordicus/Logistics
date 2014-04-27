class LOG {
	class functions {
		class init {
			file = "logistics\init.sqf";
			postInit = 1;
		};
		class serverInit {
			file = "logistics\server.sqf";
			preInit = 1;
		};
	
		file = "logistics\functions";
		class getCorner{};
		class objectDemensions{};
		class pickupObject{};
		class positionHeldObject{};
		class releaseObject{};
		class getObjectCorner{};
		class distanceFromObject{};
		class getPointerObject{};
		class addPlayerActions{};
		class resetActionConditions{};
		class enableKeybinds{};
		class disableKeybinds{};
		class renameAction{};
		class towVehicle{};
		class releaseTowedObject{};
		class isTowable{};
		class showContents{};
		class unloadItem{};
		class containerSize{};
		class loadInObject{};
		class isMoveable{};
		class roomUsed{};
		class hasRoom{};
		class safeWeapon{};
		class matchterrain{};
		class polar2vect{};
		class addEventHandler{};
		class removeEventHandler{};
		class triggerEvent{};
		class objectSize{};
		class createObjectCam{};
		class destroyObjectCam{};
		class itemName{};
		
		class config {
			file = "log_config.sqf";
		};
	};
};