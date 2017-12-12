/*::::::::::::::::/*
Fireball: 1st Circle, Wizard & Sorcerer
A cone of fire shoots forth from the caster's hands, burning all those within
its area of effect for 1d4 fire damage per caster level, up to a maximum of 5d4.
Additionally, applies 10% Fire Damage Vulnerability for 3 rounds.
/*::::::::::::::::*/

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }


    //Declare major variables
    float fDist;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;

    object oTarget;

    effect eFire;
    effect eVuln;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

    if (nCasterLevel > 5)
    {
        nCasterLevel = 5;
    }

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);

    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Signal spell cast at event to fire.
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BURNING_HANDS));
            //Calculate the delay time on the application of effects based on the distance
            //between the caster and the target
            fDist = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Make SR check, and appropriate saving throw.
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDist) && oTarget != OBJECT_SELF)
            {
                nDamage = d4(nCasterLevel);
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDamage = 4 * nCasterLevel;//Damage is at max
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                     nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                }
                //Run the damage through the various reflex save and evasion feats
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                eFire = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                eVuln = EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE, 10);
                if(nDamage > 0)
                {
                    // Apply effects to the currently selected target.
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDist, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVuln, oTarget, 18.0));
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 10.0, GetSpellTargetLocation(), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
