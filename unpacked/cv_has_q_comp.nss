#include "inc_quest"
int StartingConditional()
{

    if(GetHasQuestCompleted(GetPCSpeaker(), GetLocalString(OBJECT_SELF, "QUEST")))
    {
        return TRUE;
    }

    else
    {
        return FALSE;
    }
}
