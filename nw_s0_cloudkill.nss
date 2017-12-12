#include "inc_spellfuncs"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    DoFogSpell(GetSpellTargetLocation(), AOE_PER_FOGKILL);
    CreateSpellWP(GetSpellTargetLocation(), IntToFloat(GetCasterLevel(OBJECT_SELF)), "AOE_CLOUDKILL");
}
