#define FILTERSCRIPT

#include <a_samp>
#include <YSI\y_iterate>
#include <YSI\y_timers>
#include <colandreas>
#include <streamer>
#include <strlib>

enum E_PLAYER_DATA {
    bool:hasPhone,
    phoneNumber[12],
    cellPlan,
    minutes,
    data,
    bool:hasCellSignal, // Cell Data
    bool:hasWifiSignal, // Wifi Data
}
new PlayerData[MAX_PLAYERS][E_PLAYER_DATA];

#include "SmartPhones\CellPhones.pwn"

#include "SmartPhones\CellPlans.pwn"

#include "SmartPhones\CellTowers.pwn"
#include "SmartPhones\WifiRouters.pwn"

#include "SmartPhones\FunctionHooks.pwn"

//#include "SmartPhones\Textdraws.pwn"

//#include "SmartPhones\Texting.pwn"
//#include "SmartPhones\Calling.pwn"
//#include "SmartPhones\DataWifi.pwn"

/* Function List
        CreateCellTower
        DestroyCellTower
        GetPlayerCellSignal
        
        CreateWifiRouter
        DestroyWifiRouter
        GetPlayerWifiSignal
*/
main() { // Compile Test
    DestroyCellTower(CreateCellTower(1080, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 500.0));
    DestroyWifiRouter(CreateWifiRouter(1080, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 500.0));
}
