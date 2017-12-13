#include "inc_spellfuncs"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }

    DoFogSpell(GetSpellTargetLocation(), AOE_PER_FOGFIRE);
    CreateSpellWP(GetSpellTargetLocation(), IntToFloat(GetCasterLevel(OBJECT_SELF)), "AOE_INCENDIARY");
    CreateSpellWP(GetSpellTargetLocation(), IntToFloat(GetCasterLevel(OBJECT_SELF)), "AOE_INCENDIARY_EXP");
}

