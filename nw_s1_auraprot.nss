//Grants allies entering deflection AC and saving throws.
#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_MOB_PROTECTION);

    object oTarget = GetSpellTargetObject();

    int nDuration = GetCasterLevel(OBJECT_SELF) / 2;
    int nMetaMagic = GetMetaMagicFeat();
    int nDurationType = DURATION_TYPE_TEMPORARY;

    //If is an NPC or summon, have the duration permanent.
    if(!GetIsPC(OBJECT_SELF))
    {
        nDurationType = DURATION_TYPE_PERMANENT;
        nDuration = 90;
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectToObject(nDurationType, eAOE, oTarget, TurnsToSeconds(nDuration));
}
