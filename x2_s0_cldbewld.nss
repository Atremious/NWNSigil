#include "inc_spellfuncs"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }

    DoFogSpell(GetSpellTargetLocation(), 39);
    CreateSpellWP(GetSpellTargetLocation(), IntToFloat(GetCasterLevel(OBJECT_SELF)), "AOE_BEWILDER");
}

