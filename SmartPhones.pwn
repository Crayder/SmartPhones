#define FILTERSCRIPT

#include <a_samp>
#include <YSI\y_iterate>
#include <YSI\y_timers>
#include <colandreas>
#include <streamer>

enum E_PLAYER_DATA {
    bool:hasPhone,
    cellPlan,
    bool:hasCellSignal, // Cell Data
    bool:hasWifiSignal, // Wifi Data
}
new PlayerData[MAX_PLAYERS][E_PLAYER_DATA];

#include "CellPhones.pwn"

#include "CellTowers.pwn"
#include "WifiRouters.pwn"

//#include "Texting.pwn"
//#include "Calling.pwn"
//#include "DataWifi.pwn"
