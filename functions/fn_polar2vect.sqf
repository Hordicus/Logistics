/*
	Description:
	Copied from CBA_fnc_polar2vect
	Creates a vector based on a inputted magnitude, direction and elevation

	Parameters:
	_mag the magnitude of the vector to create
	_dir the direction of the vector to create
	_elev the elevation of the vector to create

	Returns:
	a vector in the form [x,z,y].
*/
private ["_mag", "_dir", "_elev", "_magCosElev", "_vx", "_vy", "_vz"];

_mag  = [_this, 0, 0, [0]] call BL_fnc_param;
_dir  = [_this, 1, 0, [0]] call BL_fnc_param;
_elev = [_this, 2, 0, [0]] call BL_fnc_param;

_magCosElev = _mag * cos(_elev);

_vx = _magCosElev * sin(_dir);
_vz = _magCosElev * cos(_dir);
_vy = _mag * sin(_elev);

[_vx, _vz, _vy]