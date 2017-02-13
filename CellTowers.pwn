// Towers are points on the map with dependant signal. The signal depends on number of collisions between the PlayerCellData and the tower and the distance between the two.
// Absolute areas (handled by streamer) will give the player independent signal. The signal will be full unless killed by a jammer.
// Jammer areas (handled by streamer) kill the player's signal no matter what (like when under water or in the middle of the forest).

#define MAX_CELL_TOWERS                     (10)
#define MAX_CELL_PLANS                      (15)
#define MAX_CELL_SIGNAL                     (500.0)

enum E_CELL_PLAN {
    bool:texting,    
    bool:textLimited,
    bool:calling,    
    bool:callLimited,
    bool:data,       
    bool:dataLimited,
    
    Float:minutes,
    Float:dataAmount
}
enum E_TOWER_DATA {
    oModel,
    Float:oX, Float:oY, Float:oZ,
    Float:oRX, Float:oRY, Float:oRZ,
    Float:signalPower,
    
    oID
}

new Iterator:CellTower<MAX_CELL_TOWERS>,
    CellPlans[MAX_CELL_PLANS][E_CELL_PLAN],
    CellTowers[MAX_CELL_TOWERS][E_TOWER_DATA]; // if(towers[i][oModel] = INVALID_OBJECT_ID) then tower doesn't exist
    
new CellPlanNames[MAX_CELL_PLANS][] = {
    "Limited Texting (%i Mins)",
    "Limited Texting (%i Mins)",
    "Limited Texting (%i Mins)",
    "Unlimited Texting",
    "Limited Texting and Calling (%i Mins)",
    "Limited Texting and Calling (%i Mins)",
    "Limited Texting and Calling (%i Mins)",
    "Unlimited Texting, Limited Calling (%i Mins)",
    "Unlimited Texting, Limited Calling (%i Mins)",
    "Unlimited Texting, Limited Calling (%i Mins)",
    "Unlimited Texting and Calling",
    "Unlimited Texting and Calling, Limited Data (%iMB)",
    "Unlimited Texting and Calling, Limited Data (%iMB)",
    "Unlimited Texting and Calling, Limited Data (%iMB)",
    "Unlimited Everything"
};



enum E_PLAYER_CELL_DATA {
    Float:signal,
    plan,
    minutes,
    data,
    
    bool:inJammerArea,
    bool:inAbsoluteArea
}
static PlayerCellData[MAX_PLAYERS][E_PLAYER_CELL_DATA];

ptask CellSignalCheck[1000](playerid) {
    new Float:pX, Float:pY, Float:pZ,
        Float:retF[15], ret[15];
    
    GetPlayerPos(playerid, pX, pY, pZ);
    
    if(PlayerData[playerid][hasPhone]) {
        if(PlayerCellData[playerid][inJammerArea]) {
            PlayerCellData[playerid][signal] = 0.0;
            PlayerData[playerid][hasCellSignal] = false;
        }
        else if(PlayerCellData[playerid][inAbsoluteArea]) {
            PlayerCellData[playerid][signal] = 5000.0;
            PlayerData[playerid][hasCellSignal] = true;
        }
        else foreach(new t: CellTower) {
            // Verify distance first.
            PlayerData[playerid][hasCellSignal] = (VectorSize(floatabs(CellTowers[t][oX] - pX), floatabs(CellTowers[t][oY] - pY), floatabs(CellTowers[t][oZ] - pZ)) < PlayerCellData[playerid][signal]);
            
            // Then collisions.
            if(PlayerData[playerid][hasCellSignal]) {
                new result = CA_RayCastMultiLine(
                        CellTowers[t][oX], CellTowers[t][oY], CellTowers[t][oZ] + 100.0, // point 100 units above tower
                        pX, pY, pZ,
                        retF, retF, retF, retF, ret
                    );
                
                // Calculate signal based on number of collisions
                PlayerCellData[playerid][signal] = ((CellTowers[t][signalPower]) - ((CellTowers[t][signalPower] / 15.0) * result));
                PlayerCellData[playerid][signal] = PlayerCellData[playerid][signal] < 0.0 ? 0.0 : PlayerCellData[playerid][signal];
                PlayerCellData[playerid][signal] = PlayerCellData[playerid][signal] > CellTowers[t][signalPower] ? CellTowers[t][signalPower] : PlayerCellData[playerid][signal];
                
                // Player has sufficient connection to tower?
                PlayerData[playerid][hasCellSignal] = (PlayerCellData[playerid][signal] > 0.0);
            }
        }
    }
}

hook OnFilterScriptInit() {
    CellPlans[0][texting] = true;
    CellPlans[0][textLimited] = true;
    CellPlans[0][minutes] = 10;
    
    CellPlans[1][texting] = true;
    CellPlans[1][textLimited] = true;
    CellPlans[1][minutes] = 25;
    
    CellPlans[2][texting] = true;
    CellPlans[2][textLimited] = true;
    CellPlans[2][minutes] = 50;
    
    CellPlans[3][texting] = true;
    CellPlans[3][textLimited] = false;
    
    CellPlans[4][texting] = true;
    CellPlans[4][textLimited] = true;
    CellPlans[4][calling] = true;
    CellPlans[4][callLimited] = true;
    CellPlans[4][minutes] = 15;
    
    CellPlans[5][texting] = true;
    CellPlans[5][textLimited] = true;
    CellPlans[5][calling] = true;
    CellPlans[5][callLimited] = true;
    CellPlans[5][minutes] = 30;
    
    CellPlans[6][texting] = true;
    CellPlans[6][textLimited] = true;
    CellPlans[6][calling] = true;
    CellPlans[6][callLimited] = true;
    CellPlans[6][minutes] = 60;
    
    CellPlans[7][texting] = true;
    CellPlans[7][textLimited] = false;
    CellPlans[7][calling] = true;
    CellPlans[7][callLimited] = true;
    CellPlans[7][minutes] = 15;
    
    CellPlans[8][texting] = true;
    CellPlans[8][textLimited] = false;
    CellPlans[8][calling] = true;
    CellPlans[8][callLimited] = true;
    CellPlans[8][minutes] = 30;
    
    CellPlans[9][texting] = true;
    CellPlans[9][textLimited] = false;
    CellPlans[9][calling] = true;
    CellPlans[9][callLimited] = true;
    CellPlans[9][minutes] = 60;
    
    CellPlans[10][texting] = true;
    CellPlans[10][textLimited] = false;
    CellPlans[10][calling] = true;
    CellPlans[10][callLimited] = false;
    
    CellPlans[11][texting] = true;
    CellPlans[11][textLimited] = false;
    CellPlans[11][calling] = true;
    CellPlans[11][callLimited] = false;
    CellPlans[11][data] = true;
    CellPlans[11][dataLimited] = true;
    CellPlans[11][dataAmount] = 20;
    
    CellPlans[12][texting] = true;
    CellPlans[12][textLimited] = false;
    CellPlans[12][calling] = true;
    CellPlans[12][callLimited] = false;
    CellPlans[12][data] = true;
    CellPlans[12][dataLimited] = true;
    CellPlans[12][dataAmount] = 50;
    
    CellPlans[13][texting] = true;
    CellPlans[13][textLimited] = false;
    CellPlans[13][calling] = true;
    CellPlans[13][callLimited] = false;
    CellPlans[13][data] = true;
    CellPlans[13][dataLimited] = true;
    CellPlans[13][dataAmount] = 100;
    
    CellPlans[14][texting] = true;
    CellPlans[14][textLimited] = false;
    CellPlans[14][calling] = true;
    CellPlans[14][callLimited] = false;
    CellPlans[14][data] = true;
    CellPlans[14][dataLimited] = false;
    
    return 1;
}

stock CreateCellTower(model, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ, Float:power) {
    new i = Iter_Free(CellTower);
    if(i != cellmin) {
        CellTowers[i][oModel] = model;
        CellTowers[i][oX] = X;
        CellTowers[i][oY] = Y;
        CellTowers[i][oZ] = Z;
        CellTowers[i][oRX] = rX;
        CellTowers[i][oRX] = rY;
        CellTowers[i][oRX] = rZ;
        CellTowers[i][signalPower] = power;
        
        // Create Object
        CellTowers[i][oID] = CreateDynamicObject(model, x, y, z, rX, rY, rZ, 500.0);
        
        Iter_Add(CellTower, i);
    }
    return i;
}

stock DestroyCellTower(id) {
    if(!Iter_Contains(CellTower, id))
        return 0;
    
    CellTowers[i][oModel] = 0;
    CellTowers[i][oX] = 0.0;
    CellTowers[i][oY] = 0.0;
    CellTowers[i][oZ] = 0.0;
    CellTowers[i][rX] = 0.0;
    CellTowers[i][rX] = 0.0;
    CellTowers[i][rX] = 0.0;
    CellTowers[i][signalPower] = 0.0;
    
    DestroyDynamicObject(CellTowers[i][oID]);
    CellTowers[i][oID] = 0;
        
    Iter_Remove(CellTower, i);
    
    return 1;
}
