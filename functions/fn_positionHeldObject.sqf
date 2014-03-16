/*
	Description:
	Positions the object in the players hand.
	
	Parameter(s):
	_distanceFromPlayer - How far the object should be from the player.
		Negative values will place it behind the player
		
	_centerFromPlayer - Offset the object left (negative value) or right (positive value)
	
	_offsetHeight - How far above or below the players feet the object should be
	
	Returns:
	held object
*/

private ["_distanceFromPlayer","_offsetHeight","_centerFromPlayer","_direction","_bb","_bbCenter","_corner","_objSize","_maxHeight","_intersects","_adjustDist","_playerPos"];
_distanceFromPlayer = [_this, 0, LOG_pos_distanceFromPlayer, [0]] call BIS_fnc_param;
_offsetHeight       = [_this, 1, LOG_pos_offsetHeight, [0]] call BIS_fnc_param;
_centerFromPlayer   = [_this, 2, LOG_pos_centerFromPlayer, [0]] call BIS_fnc_param;
_direction          = [_this, 3, LOG_pos_direction, [0]] call BIS_fnc_param;

if ( _direction > 360 ) then {
	_direction = _direction - 360;
};

if ( _direction < 0 ) then {
	_direction = _direction + 360;
};

LOG_pos_distanceFromPlayer = _distanceFromPlayer;
LOG_pos_offsetHeight       = _offsetHeight;
LOG_pos_centerFromPlayer   = _centerFromPlayer;
LOG_pos_direction          = _direction;

// Detach object so we can reattach with new positioning
detach LOG_currentObject;

_bb = boundingBoxReal LOG_currentObject;
_bbCenter = boundingCenter LOG_currentObject;


_corner = [_bbCenter select 0, _bbCenter select 1, _bb select 1 select 0, _bb select 1 select 1, _direction] call LOG_fnc_getCorner;

_objSize   = LOG_currentObject call LOG_fnc_objectSize;
_maxHeight = _objSize select 2;

_intersects = [LOG_currentObject];

_adjustDist = 0;
while { LOG_currentObject in _intersects } do {
	LOG_currentObject attachTo [player, [
		_centerFromPlayer,
		// (_distanceFromPlayer + (abs(_corner select 0) max abs(_corner select 1))),
		_distanceFromPlayer + abs(_corner select 1) + _adjustDist,
		// _offsetHeight + (_bbCenter select 2)
		(_bbCenter select 2)
	]];

	LOG_currentObject setDir _direction;

	_playerPos = getPosATL player;
	_intersects = lineIntersectsWith [ATLtoASL _playerPos, ATLtoASL [_playerPos select 0, _playerPos select 1, (_playerPos select 2)-_maxHeight]];

	_adjustDist = _adjustDist + 1;
};

// Final positioning
LOG_currentObject attachTo [player, [
	_centerFromPlayer,
	// (_distanceFromPlayer + (abs(_corner select 0) max abs(_corner select 1))),
	_distanceFromPlayer + abs(_corner select 1) + _adjustDist-1,
	_offsetHeight + (_bbCenter select 2)
]];


LOG_currentObject