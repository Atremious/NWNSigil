#include "inc_quest"
void main()
{
    object oPC  = GetEnteringObject();
    object oNPC = GetObjectByTag(GetLocalString(OBJECT_SELF, "NPC"));

    string sQuest = GetLocalString(OBJECT_SELF, "QUEST");
    string sMsg   = GetLocalString(OBJECT_SELF, "MSG");

    int nAnimation = GetLocalInt(OBJECT_SELF, "ANIMATION");

    if(GetHasQuestInProgress(oPC, sQuest) && !GetLocalInt(OBJECT_SELF, GetName(oPC)))
    {
        SetLocalInt(OBJECT_SELF, GetName(oPC), 1);

        if(sMsg != "")
        {
            AssignCommand(oNPC, SpeakString(sMsg));
            SendMessageToPC(oPC, GetName(oNPC) + " speaks to you..");
        }

        if(nAnimation != 0)
        {
            AssignCommand(oNPC, ActionPlayAnimation(nAnimation, 1.0, 1.5));
        }

        DelayCommand(300.0, DeleteLocalInt(OBJECT_SELF, GetName(oPC)));
    }
}
