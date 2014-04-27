if ( !isNil "LOG_itemCam" ) then {
	(LOG_itemCam select 0) cameraEffect ["TERMINATE", "BACK"];
	camDestroy (LOG_itemCam select 0);
	deleteVehicle (LOG_itemCam select 1);
	deleteVehicle (LOG_itemCam select 2);
};