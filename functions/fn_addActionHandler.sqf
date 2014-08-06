private ['_action'];
_action = LOG_actions select (_this select 3);
(_action select 2) call (_action select 1);

nil