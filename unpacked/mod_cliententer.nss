#include "x3_inc_horse"
#include "inc_gen"
#include "inc_quest"

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

    int nPlayers  = GetLocalInt(OBJECT_SELF, "PLAYER_COUNT");
    SetLocalInt(OBJECT_SELF, "PLAYER_COUNT", nPlayers++);

              //123456789112345
    LogMessage("[PLAYERCOUNT]: " + IntToString(GetLocalInt(OBJECT_SELF, "PLAYER_COUNT")));

    DoJournalUpdate(oPC);

}
