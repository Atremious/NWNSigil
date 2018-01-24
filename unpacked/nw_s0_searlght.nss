//Searing Light

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt = 1;

    effect eLightning = EffectBeam(VFX_BEAM_HOLY, OBJECT_SELF, BODY_NODE_HAND);
    effect eVis  = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eDamage;

    object oTarget = GetSpellTargetObject();
    object oPC = OBJECT_SELF;
    object oNextTarget, oTarget2;

    location lTarget = GetLocation(oTarget);

    float fDelay;

    if (nCasterLevel > 10)
    {
        nCasterLevel = 10;
    }

    oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oTarget2) && GetDistanceToObject(oTarget2) <= 30.0)
    {
        oTarget = GetFirstObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetPosition(OBJECT_SELF));
        while (GetIsObjectValid(oTarget))
        {
           if (oTarget != OBJECT_SELF && oTarget2 == oTarget)
           {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                {
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SEARING_LIGHT));
                   if (!MyResistSpell(OBJECT_SELF, oTarget))
                   {
                        if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                        {
                            nDamage =  d8(nCasterLevel/2);
                        }

                        if(GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
                        {
                            nDamage =  d6(nCasterLevel/2);
                        }

                        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || GetLevelByClass(CLASS_TYPE_PALEMASTER, oPC) >= 1)
                        {
                            nDamage =  d8(nCasterLevel);
                        }

                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        {

                            if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
                            {
                                nDamage =  8*(nCasterLevel/2);
                            }

                            if(GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
                            {
                                nDamage =  6*(nCasterLevel/2);
                            }

                            if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || GetLevelByClass(CLASS_TYPE_PALEMASTER, oPC) >= 1)
                            {
                                nDamage =  8*nCasterLevel;
                            }
                        }

                        if (nMetaMagic == METAMAGIC_EMPOWER)
                        {
                             nDamage = nDamage + (nDamage/2);
                        }

                        if(GetHasFeat(FEAT_SUN_DOMAIN_POWER, oPC))
                        {
                            nDamage = nDamage + (nDamage/2);
                        }

                        //Set damage effect
                        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_DIVINE);
                        if(nDamage > 0)
                        {
                            fDelay = GetSpellEffectDelay(GetLocation(oTarget), oTarget);
                            //Apply VFX impcat, damage effect and lightning effect
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget));
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget));
                        }
                    }
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLightning,oTarget,1.0);
                    //Set the currect target as the holder of the lightning effect
                    oNextTarget = oTarget;
                    eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oNextTarget, BODY_NODE_CHEST);
                }
           }
           //Get the next object in the lightning cylinder
           oTarget = GetNextObjectInShape(SHAPE_SPELLCYLINDER, 30.0, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, GetPosition(OBJECT_SELF));
        }
        nCnt++;
        oTarget2 = GetNearestObject(OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nCnt);
    }
}


