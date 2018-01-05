#include "inc_gen"
void main()
{
    object oPC = GetPCLevellingUp();
    string sArea = GetName(GetArea(oPC));

    LogMessage("[LVLUP]: " + GetName(oPC) + " (" + GetPCPublicCDKey(oPC) + ") [" + sArea + "] Level Up: Now " + IntToString(GetHitDice(oPC)) + ".");

}
