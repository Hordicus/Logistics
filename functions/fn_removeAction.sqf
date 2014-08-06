private ['_id', '_realId'];
_id = [_this, 0, -1, [0]] call BL_fnc_param;

_realId = LOG_actionsIds select _id;

player removeAction _realId;

LOG_actions set [_id, nil];
LOG_actionsIds set [_id, nil];

nil