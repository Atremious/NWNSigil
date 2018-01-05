#include "inc_nbde"
#include "inc_gen"
void main()
{
    object oPC = GetExitingObject();

    string sPC     = GetName(oPC);
    string sKey    = GetPCPublicCDKey(oPC);
    string sPlayer = GetPCPlayerName(oPC);

    int nXP = GetXP(oPC);

    int nPlayers  = GetLocalInt(OBJECT_SELF, "PLAYER_COUNT");
    SetLocalInt(OBJECT_SELF, "PLAYER_COUNT", nPlayers--);

    LogMessage("[PLAYERCOUNT]: " + IntToString(GetLocalInt(OBJECT_SELF, "PLAYER_COUNT")));
}
