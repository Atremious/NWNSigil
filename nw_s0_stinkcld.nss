#include "inc_spellfuncs"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }

    DoFogSpell(GetSpellTargetLocation(), AOE_PER_FOGSTINK);
    CreateSpellWP(GetSpellTargetLocation(), IntToFloat(GetCasterLevel(OBJECT_SELF)), "AOE_STINKING");
    CreateSpellWP(GetSpellTargetLocation(), IntToFloat(GetCasterLevel(OBJECT_SELF)), "AOE_STINKING_EXP");
}

