stock _SetPlayerPos(playerid, Float:x, Float:y, Float:z) {
	defer CellSignalCheck[50](playerid);
	defer WifiSignalCheck[50](playerid);
	return SetPlayerPos(playerid, x, y, z);
}

#if defined _ALS_SetPlayerPos
	#undef SetPlayerPos
#else
	#define _ALS_SetPlayerPos
#endif
#define SetPlayerPos _SetPlayerPos
