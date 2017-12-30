#include "inc_nbde"
void main()
{
    object oPC = GetExitingObject();

    string sPC     = GetName(oPC);
    string sKey    = GetPCPublicCDKey(oPC);
    string sPlayer = GetPCPlayerName(oPC);

    int nXP = GetXP(oPC);
    int nLeaveCount = GetLocalInt(OBJECT_SELF, "LEAVE_COUNT");

    nLeaveCount++;

    if(nLeaveCount == 5)
    {
        SetLocalInt(OBJECT_SELF, "LEAVE_COUNT", 0);
        DelayCommand(5.0, NBDE_FlushCampaignDatabase("PLAYERNAME_DATA"));
    }

}
