#include "nw_i0_generic"
//When given to an NPC, this NPC will flee all PCs.
void main()
{
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

    object oPC = GetLastPerceived();

    if(GetIsPC(oPC))
    {
        SetLocalObject(OBJECT_SELF, "FLEE_FROM", oPC);
        ActionMoveAwayFromObject(oPC, TRUE, 40.0);

        DelayCommand(6.0, ExecuteScript("cr_flee_ext", OBJECT_SELF));
    }
}




