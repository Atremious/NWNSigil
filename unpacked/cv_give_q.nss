#include "inc_quest"
void main()
{
    object oPC   = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    string sQuest = GetLocalString(oSelf, "QUEST");

    if(GetHasQuest(oPC, sQuest))
    {
        SendMessageToPC(oPC, "You already have this quest in progress, " +
        "or have completed it.");
        return;
    }

    if(!GetHasQuest(oPC, sQuest))
    {
        GiveQuest(oPC, sQuest);
    }
}
