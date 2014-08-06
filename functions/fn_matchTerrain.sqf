private ['_obj'];
_obj = [_this, 0, objNull, [objNull]] call BL_fnc_param;

_obj setVectorUp ([(surfaceNormal (getPosATL _obj)), (getDir player)] call BIS_fnc_rotateVector2D);