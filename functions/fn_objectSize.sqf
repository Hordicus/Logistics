/*
	Description:
	Uses boundingBoxReal on an object to find it's max dimensions
	
	Parameter(s):
	_object - Object to run boundingBoxReal on
	
	Returns:
	Array - [_maxWidth, _maxLength, _maxHeight]
*/

private ['_object', '_bb', '_p1', '_p2', '_maxWidth', '_maxLength', '_maxHeight'];
_object = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_bb = boundingBoxReal _object;
_p1 = _bb select 0;
_p2 = _bb select 1;

_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
_maxLength = abs ((_p2 select 1) - (_p1 select 1));
_maxHeight = abs ((_p2 select 2) - (_p1 select 2));

[_maxWidth, _maxLength, _maxHeight]