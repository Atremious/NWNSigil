#include "inc_quest"
int StartingConditional()
{

    if(!GetHasQuest(GetPCSpeaker(), GetLocalString(OBJECT_SELF, "QUEST")))
    {
        return TRUE;
    }

    else
    {
        return FALSE;
    }
}
