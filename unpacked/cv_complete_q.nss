#include "inc_quest"
void main()
{
    object oPC   = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    string sQuest = GetLocalString(oSelf, "QUEST");

    int nGP = 0;
    int nXP = 0;

    if(GetLocalInt(oSelf, "QUEST_GP_OVERRIDE") > 0)
    {
        nGP = GetLocalInt(oSelf, "QUEST_GP_OVERRIDE");
    }

    if(GetLocalInt(oSelf, "QUEST_XP_OVERRIDE") > 0)
    {
        nXP = GetLocalInt(oSelf, "QUEST_XP_OVERRIDE");
    }

    CompleteQuest(oPC, sQuest, nGP, nXP);
}
