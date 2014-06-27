private ['_class', '_renderTarget', '_objPos', '_obj', '_objDim', '_lightPos', '_light'];
_class  = [_this, 0, "", [""]] call BL_fnc_param;
_renderTarget = [_this, 1, "rendertarget45", [""]] call BL_fnc_param;
_objPos = [_this, 2, [10,10,10000], [[]], [3]] call BL_fnc_param;

[] call LOG_fnc_destroyObjectCam;

_obj = _class createVehicleLocal _objPos;
_obj enableSimulation false;
_obj setPosATL _objPos;

_objDim = _obj call LOG_fnc_objectDemensions;

_cam = "camera" camCreate [0,0,0];
_cam camSetPos (position _obj);
_cam cameraEffect ["INTERNAL", "BACK", _renderTarget];
_cam camSetTarget _obj;
_cam camSetRelPos [sizeOf _class, 0, (_objDim select 2)/2];
_cam camCommit 0;

_obj setDir -45;

_lightPos = +_objPos;
_lightPos set [2, (_objPos select 2) + 10];

_light = "#lightpoint" createVehicleLocal _lightPos;
_light setLightBrightness 10;
_light setLightAmbient[1.0, 1.0, 1.0];
_light setLightColor[1.0, 1.0, 1.0];

_obj spawn {
	while { !isNull _this } do {
		_this setDir (getDir _this) + 1;
		sleep 0.05;
	};
};

LOG_itemCam = [_cam, _obj, _light]