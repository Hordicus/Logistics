/*
	Description:
	Removes event handler for keybinds from main display
*/

(findDisplay 46) displayRemoveEventHandler ["KeyDown", LOG_keyBindID];
LOG_keyBindID = -1;