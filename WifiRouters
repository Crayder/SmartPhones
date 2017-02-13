#define MAX_WIFI_ROUTERS

enum E_ROUTER_DATA {
    oModel,
    Float:oX, Float:oY, Float:oZ,
    Float:oRX, Float:oRY, Float:oRZ,
    Float:signalPower,
    
    oID
}

new Iterator:WifiRouter<MAX_CELL_TOWERS>,
    WifiRouters[MAX_CELL_TOWERS][E_ROUTER_DATA];

enum E_PLAYER_WIFI_DATA {
    Float:signal
}
static PlayerWifiData[MAX_PLAYERS][E_PLAYER_CELL_DATA];

ptask WifiSignalCheck[1000](playerid) {
    new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);
    
    if(PlayerData[playerid][hasPhone]) {
        foreach(new w: WifiRouter) {
            PlayerData[playerid][hasWifiSignal] = (VectorSize(floatabs(WifiRouters[w][oX] - pX), floatabs(WifiRouters[w][oY] - pY), floatabs(WifiRouters[w][oZ] - pZ)) < PlayerWifiData[playerid][signal]);
        }
    }
}

stock CreateWifiRouter(model, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ, Float:power) {
    new i = Iter_Free(WifiRouter);
    if(i != cellmin) {
        WifiRouters[i][oModel] = model;
        WifiRouters[i][oX] = X;
        WifiRouters[i][oY] = Y;
        WifiRouters[i][oZ] = Z;
        WifiRouters[i][oRX] = rX;
        WifiRouters[i][oRX] = rY;
        WifiRouters[i][oRX] = rZ;
        WifiRouters[i][signalPower] = power;
        
        // Create Object
        WifiRouters[i][oID] = CreateDynamicObject(model, x, y, z, rX, rY, rZ, 500.0);
        
        Iter_Add(WifiRouter, i);
    }
    return i;
}

stock DestroyWifiRouter(id) {
    if(!Iter_Contains(WifiRouter, id))
        return 0;
    
    WifiRouters[i][oModel] = 0;
    WifiRouters[i][oX] = 0.0;
    WifiRouters[i][oY] = 0.0;
    WifiRouters[i][oZ] = 0.0;
    WifiRouters[i][rX] = 0.0;
    WifiRouters[i][rX] = 0.0;
    WifiRouters[i][rX] = 0.0;
    WifiRouters[i][signalPower] = 0.0;
    
    DestroyDynamicObject(WifiRouters[i][oID]);
    WifiRouters[i][oID] = 0;
        
    Iter_Remove(WifiRouter, i);
    
    return 1;
}
