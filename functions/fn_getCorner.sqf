/*
	Description:
	Gets the bounding box of a rotated rectangle
	Based off of:
	http://abdiassoftware.com/blog/2013/10/get-bounding-box-of-a-rotated-rectangle/
	
	Parameter(s):
	_pivotX
	_pivotY
	_cornerX
	_cornerY
	_angle
	
	Returns:
	Array - [x, y]
*/

private ["_pivotX","_pivotY","_cornerX","_cornerY","_angle","_diffX","_diffY","_distance","_y","_x"];

_pivotX  = [_this, 0, 0, [0]] call BIS_fnc_param;
_pivotY  = [_this, 1, 0, [0]] call BIS_fnc_param;
_cornerX = [_this, 2, 0, [0]] call BIS_fnc_param;
_cornerY = [_this, 3, 0, [0]] call BIS_fnc_param;
_angle   = [_this, 4, 0, [0]] call BIS_fnc_param;

// get distance from center to point
_diffX = _cornerX - _pivotX;
_diffY = _cornerY - _pivotY;
_distance = sqrt(_diffX * _diffX + _diffY * _diffY);

// find angle from pivot to corner
_angle = _angle + (_diffY atan2 _diffX);

// get new x and y and round it off to integer
_x = _pivotX + _distance * cos _angle;
_y = _pivotY + _distance * sin _angle;

[_x, _y]