#include "x3_inc_horse"
#include "inc_nbde"
#include "inc_gen"

void main()
{
    object oPC=GetEnteringObject();
    ExecuteScript("x3_mod_pre_enter",OBJECT_SELF); // Override for other skin systems
    if ((GetIsPC(oPC)||GetIsDM(oPC))&&!GetHasFeat(FEAT_HORSE_MENU,oPC))
    { // add horse menu
        HorseAddHorseMenu(oPC);
        if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB"))
        { // restore PC horse status from database
            DelayCommand(2.0,HorseReloadFromDatabase(oPC,X3_HORSE_DATABASE));
        } // restore PC horse status from database
    } // add horse menu
    if (GetIsPC(oPC))
    { // more details
        // restore appearance in case you export your character in mounted form, etc.
        if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
        // pre-cache horse animations for player as attaching a tail to the model
        HorsePreloadAnimations(oPC);
        DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
    } // more details

    SendMessageToPC(oPC, "Welcome to " + GetName(GetModule()) + "! " +
    "Read your journal for updated information about contact and server changes.");

    //If a playername doesn't have a recorded CDKey, new player! Record key.
    if(NBDE_GetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY") == "")
    {
        NBDE_SetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY", GetPCPublicCDKey(oPC, TRUE));
    }

    //If not a new player, and the recorded key doesn't match the current key.. send flag.
    if(NBDE_GetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY") != ""
    && NBDE_GetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY") != GetPCPublicCDKey(oPC, TRUE))
    {
        LogMessage("FLAG: Key " + GetPCPublicCDKey(oPC, TRUE) + " attempting to log into account " + GetPCPlayerName(oPC) +
        ". Valid key of " + GetPCPlayerName(oPC) + " is " + NBDE_GetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY"));

        SendMessageToAllDMs("FLAG: Key " + GetPCPublicCDKey(oPC, TRUE) + " attempting to log into account " + GetPCPlayerName(oPC) +
        ". Valid key of " + GetPCPlayerName(oPC) + " is " + NBDE_GetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY"));
    }

}
