#define MAX_CELL_PLANS                      (15)

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
new CellPlans[MAX_CELL_PLANS][E_CELL_PLAN];

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
