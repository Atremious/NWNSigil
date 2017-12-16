#include "inc_loot"
void main()
{
    object oPC = GetLastUsedBy();

    float fDur = GetLocalFloat(OBJECT_SELF, "COOLDOWN_DUR");

    if(GetLocalString(OBJECT_SELF, GetName(oPC)) == "" && !GetLocked(OBJECT_SELF))
    {
        SetLocalString(OBJECT_SELF, GetName(oPC), "USED");

        GenerateLoot(oPC, GetLocalString(OBJECT_SELF, "LOOT_CONTAINER_TAG"));
        GenerateGold(oPC, GetLocalInt(OBJECT_SELF, "LOOT_GP_BASE"), GetLocalInt(OBJECT_SELF, "LOOT_GP_RANDOM"));

        ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN);
        DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE));

        if(fDur > 0.0)
        {
            DelayCommand(fDur, SetLocalString(OBJECT_SELF, GetName(oPC), ""));
        }
    }
}
