#define MAX_WIFI_ROUTERS

enum E_ROUTER_DATA {
    oModel,
    Float:oX, Float:oY, Float:oZ,
    Float:oRX, Float:oRY, Float:oRZ,
    Float:signalPower,
    
    oID,
    Text3D:text
}

new Iterator:WifiRouter<MAX_CELL_TOWERS>,
    WifiRouters[MAX_CELL_TOWERS][E_ROUTER_DATA];

enum E_PLAYER_WIFI_DATA {
    Float:signal
}
new PlayerWifiData[MAX_PLAYERS][E_PLAYER_CELL_DATA];
#define GetPlayerWifiSignal(%0)     (PlayerWifiData[%0][signal])

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
        WifiRouters[i][oX] = x;
        WifiRouters[i][oY] = y;
        WifiRouters[i][oZ] = z;
        WifiRouters[i][oRX] = rX;
        WifiRouters[i][oRX] = rY;
        WifiRouters[i][oRX] = rZ;
        WifiRouters[i][signalPower] = power;
        
        // Create Object
        WifiRouters[i][oID] = CreateDynamicObject(model, x, y, z, rX, rY, rZ, -1, -1, -1, 500.0);
        WifiRouters[i][text] = Create3DTextLabel(sprintf("WiFi Router #%i\nSignal Power: %0.2f", i, power), 0xAAFF00FF, x, y, z, 10.0, -1, true);
        
        Iter_Add(WifiRouter, i);
    }
    return i;
}

stock DestroyWifiRouter(id) {
    if(!Iter_Contains(WifiRouter, id))
        return 0;
    
    WifiRouters[id][oModel] = 0;
    WifiRouters[id][oX] = 0.0;
    WifiRouters[id][oY] = 0.0;
    WifiRouters[id][oZ] = 0.0;
    WifiRouters[id][oRX] = 0.0;
    WifiRouters[id][oRY] = 0.0;
    WifiRouters[id][oRZ] = 0.0;
    WifiRouters[id][signalPower] = 0.0;
    
    DestroyDynamicObject(WifiRouters[id][oID]);
    WifiRouters[id][oID] = 0;
    Delete3DTextLabel(WifiRouters[id][text]);
    WifiRouters[id][text] = Text3D:0;
        
    Iter_Remove(WifiRouter, id);
    
    return 1;
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
