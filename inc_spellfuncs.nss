#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
/*::::::::::::::::/*
inc_spellfuncs
This include will be a consolidation of common spells, like Fireball.
Allows these spell functions to be called outside of spell scripts easily.
/*::::::::::::::::*/


//Returns true of sSearch is set to any value on any of oPC's equipped items.
int GetHasStringOnEquippedItems(object oPC, string sSearch);
int GetHasStringOnEquippedItems(object oPC, string sSearch)
{
    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_BELT, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_NECK, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC), sSearch) != "")
    {
        return TRUE;
    }

    if(GetLocalString(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC), sSearch) != "")
    {
        return TRUE;
    }

    else
    {
        return FALSE;
    }
}

/*::::::::::::::::/*
lLoc      | Location to create the SpellWP at.
fDur      | Duration for the SpellWP to last.
sTag      | Tag of the SpellWP.
SpellWPs are used to track nearby spell casts,
like grease.
/*::::::::::::::::*/
void CreateSpellWP(location lLoc, float fDur, string sTag);
void CreateSpellWP(location lLoc, float fDur, string sTag)
{
    string sTemplate = "NW_WAYPOINT001";
    object SpellWP = CreateObject(OBJECT_TYPE_WAYPOINT, sTemplate, lLoc, FALSE, "SPL_WP_" + sTag);

    DelayCommand(fDur, DestroyObject(SpellWP));
}

/*::::::::::::::::/*
Returns the nearest SpellWP defined by sTag.
Example: GetNearestSpellWP("GREASE");
/*::::::::::::::::*/
object GetNearestSpellWP(string sTag);
object GetNearestSpellWP(string sTag)
{
    string sWP = "SPL_WP_" + sTag;

    return GetNearestObjectByTag(sWP);
}

/*::::::::::::::::/*
lLoc      | Location for the Wall of Fire to go off at.
/*::::::::::::::::*/
void DoWallOfFire(location lLoc);
void DoWallOfFire(location lLoc)
{
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLFIRE);
    int nDuration = GetCasterLevel(OBJECT_SELF) / 2;
    if(nDuration == 0)
    {
        nDuration = 1;
    }
    int nMetaMagic = GetMetaMagicFeat();

        //Check fort metamagic
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2;   //Duration is +100%
        }
    //Create the Area of Effect Object declared above.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(nDuration));

    object oWP = GetNearestSpellWP("GREASE");

    if(GetDistanceBetweenLocations(GetLocation(oWP), lLoc) <= 1.0 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP))
    {
        SetLocalInt(oWP, "USED", 1);
        DestroyObject(oWP);

        DoWallOfFire(GetLocation(oWP));
    }
}

/*::::::::::::::::/*
lLoc      | Location for the Fireball to go off at.
nCL       | Caster Level for the fireball.
nCL_Limit | Caster Level limit for the fireball.
nDMG      | Use if you want to override the spell's damage.
nDMG_Type | Damage type to deal.
/*::::::::::::::::*/
void DoFireball(location lLoc, int nCL = 0, int nCL_Limit = 10, int nDMG = 0, int nDMG_Type = DAMAGE_TYPE_FIRE);
void DoFireball(location lLoc, int nCL = 0, int nCL_Limit = 10, int nDMG = 0, int nDMG_Type = DAMAGE_TYPE_FIRE)
{
    object oCaster = OBJECT_SELF;

    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;

    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;

    if(nCL > nCasterLvl)
    {
        nCasterLvl = nCL;
    }

    location lTarget = lLoc;

    if (nCasterLvl > nCL_Limit)
    {
        nCasterLvl = nCL_Limit;
    }
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            if((GetSpellId() == 341) || GetSpellId() == 58)
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL));
                //Get the distance between the explosion and the target to calculate delay
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    //Roll damage for each target
                    nDamage = d6(nCasterLvl);
                    //Resolve metamagic
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 6 * nCasterLvl;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage / 2;
                    }

                    if(nDMG > 0)
                    {
                       nDamage = nDMG;
                    }
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                    //Set the damage effect
                    eDam = EffectDamage(nDamage, nDMG_Type);
                    if(nDamage > 0)
                    {
                        // Apply effects to the currently selected target.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        //This visual effect is applied to the target object not the location as above.  This visual effect
                        //represents the flame that erupts on the target not on the ground.
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }

    object oWP;

    oWP = GetNearestSpellWP("GREASE");
    if(GetDistanceBetweenLocations(GetLocation(oWP), lLoc) <= 6.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP))
    {
        SetLocalInt(oWP, "USED", 1);
        DestroyObject(oWP);

        DoWallOfFire(GetLocation(oWP));
        AssignCommand(oCaster, SpeakString("grease found"));
    }

    oWP = GetNearestSpellWP("AOE_STINKING_EXP");
    if(GetDistanceBetweenLocations(GetLocation(oWP), lLoc) <= 6.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP))
    {
        SetLocalInt(oWP, "USED", 1);
        DestroyObject(oWP);

        DoFireball(GetLocation(oWP), 0, 10, 100, DAMAGE_TYPE_COLD);
        AssignCommand(oCaster, SpeakString("AoE Stinking found"));
    }

    oWP = GetNearestSpellWP("AOE_INCENDIARY_EXP");
    if(GetDistanceBetweenLocations(GetLocation(oWP), lLoc) <= 6.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP))
    {
        SetLocalInt(oWP, "USED", 1);
        DestroyObject(oWP);

        DoFireball(GetLocation(oWP));
        DoFireball(GetLocation(oWP));
    }
}

/*::::::::::::::::/*
lLoc      | Location for the Wall of Fire to go off at.
/*::::::::::::::::*/
void DoGrease(location lLoc);
void DoGrease(location lLoc)
{
    effect eAOE = EffectAreaOfEffect(AOE_PER_GREASE);
    effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);

    int nDuration = 2 + GetCasterLevel(OBJECT_SELF) / 3;

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);
    int nMetaMagic = GetMetaMagicFeat();
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLoc, RoundsToSeconds(nDuration));
    CreateSpellWP(lLoc, IntToFloat(nDuration), "GREASE");
}

/*::::::::::::::::/*
lLoc          | Location for the Wall of Fire to go off at.
nVFX          | The beam VFX to use.
nDiceOverride | The number of d4 dice to use.
/*::::::::::::::::*/
void DoGedlees(location lTarget, int nVFX = VFX_BEAM_LIGHTNING, int nDiceOverride = 0, float fSize = RADIUS_SIZE_MEDIUM);
void DoGedlees(location lTarget, int nVFX = VFX_BEAM_LIGHTNING, int nDiceOverride = 0, float fSize = RADIUS_SIZE_MEDIUM)
{

    int      nMetaMagic = GetMetaMagicFeat();
    int      nDamage;
    int      nPotential;

    object   oLastValid;

    effect   eBeam;
    effect   eDam;
    effect   eStrike = EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    effect   eStun   = EffectLinkEffects(EffectVisualEffect(VFX_IMP_STUN),EffectStunned());

    float    fDelay;

    int nNumDice = GetCasterLevel(OBJECT_SELF)/2;
    if (nNumDice<1)
    {
        nNumDice = 1;
    }
    else if (nNumDice >5)
    {
        nNumDice = 5;
    }

    if(nDiceOverride > 0)
    {
        nNumDice = nDiceOverride;
    }


    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

            if (GetIsObjectValid(oLastValid))
            {
                   fDelay += 0.2f;
                   fDelay += GetDistanceBetweenLocations(GetLocation(oLastValid), GetLocation(oTarget))/20;
            }
            else
            {
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
            }

            if (GetIsObjectValid(oLastValid))
            {
                 eBeam = EffectBeam(nVFX, oLastValid, BODY_NODE_CHEST);
                 DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam,oTarget,1.5f));
            }

            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {

                nPotential = MaximizeOrEmpower(6, nNumDice, nMetaMagic);
                nDamage    = GetReflexAdjustedDamage(nPotential, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY);

                //--------------------------------------------------------------
                // If we failed the reflex save, we save vs will or are stunned
                // for one round
                //--------------------------------------------------------------
                if (nPotential == nDamage || (GetHasFeat(FEAT_IMPROVED_EVASION,oTarget) &&  nDamage == (nPotential/2)))
                {
                    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStun,oTarget, RoundsToSeconds(1)));
                    }

                }


                if (nDamage >0)
                {
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eStrike, oTarget));
                 }
            }

            //------------------------------------------------------------------
            // Store Target to make it appear that the lightning bolt is jumping
            // from target to target
            //------------------------------------------------------------------
            oLastValid = oTarget;

        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget, TRUE, OBJECT_TYPE_CREATURE );
    }
}

/*::::::::::::::::/*
lTarget  | Location for the Acid Fog to go off at.
nAoE     | The integer value of the AoE (e.g. AOE_PER_FOGACID)
nVFX 	 | VFX Override for the impact at the fog spell.
/*::::::::::::::::*/
void DoFogSpell(location lTarget, int nAoE = AOE_PER_FOGACID, int nVFX = 257);
void DoFogSpell(location lTarget, int nAoE = AOE_PER_FOGACID, int nVFX = 257)
{

    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(nAoE);

    int nDuration = GetCasterLevel(OBJECT_SELF) / 2;
    int nMetaMagic = GetMetaMagicFeat();
    effect eImpact = EffectVisualEffect(nVFX);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));

}

/*::::::::::::::::/*
lLoc           | Location for the Wall of Fire to go off at.
nBlow          | If set to 1, will blow the area of effect instead of dispelling it.
/*::::::::::::::::*/
void DoGustOfWind(location lTarget, int nBlow = 0);
void DoGustOfWind(location lTarget, int nBlow = 0)
{
    string sAOETag;

    object oCaster = OBJECT_SELF;

    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;

    float fDelay;

    effect eExplode = EffectVisualEffect(VFX_FNF_LOS_NORMAL_20);
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    object oWP;
    float nDistance = GetDistanceBetweenLocations(GetLocation(oWP), lTarget);

    AssignCommand(oCaster, SpeakString("nBlow is " + IntToString(nBlow) + " .. nDistance is " + FloatToString(nDistance)));

        oWP = GetNearestSpellWP("AOE_INCENDIARY");

        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            location f1 = GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0);
            location f2 = GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0);
            location f3 = GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0);

            DoFogSpell(f1, AOE_PER_FOGFIRE, VFX_NONE);
            DoFogSpell(f2, AOE_PER_FOGFIRE, VFX_NONE);
            DoFogSpell(f3, AOE_PER_FOGFIRE, VFX_NONE);
        }

        oWP = GetNearestSpellWP("AOE_ACIDFOG");
        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGACID, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGACID, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGACID, VFX_NONE);
        }

        oWP = GetNearestSpellWP("AOE_CLOUDKILL");
        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGKILL, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGKILL, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGKILL, VFX_NONE);
        }

        oWP = GetNearestSpellWP("AOE_MINDFOG");
        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGMIND, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGMIND, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGMIND, VFX_NONE);
        }

        oWP = GetNearestSpellWP("AOE_STINKING");
        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGSTINK, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGSTINK, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), AOE_PER_FOGSTINK, VFX_NONE);
        }

        oWP = GetNearestSpellWP("AOE_BEWILDER");
        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), 39, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), 39, VFX_NONE);
            DoFogSpell(GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0), 39, VFX_NONE);
        }

        oWP = GetNearestSpellWP("GREASE");
        if(nDistance <= 1.5 && !GetLocalInt(oWP, "USED") && GetIsObjectValid(oWP) && nBlow == 1)
        {
            SetLocalInt(oWP, "USED", 1);
            DestroyObject(oWP);

            DoGrease(GenerateNewLocationFromLocation(lTarget, 2.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0));
            DoGrease(GenerateNewLocationFromLocation(lTarget, 6.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0));
            DoGrease(GenerateNewLocationFromLocation(lTarget, 10.0 + IntToFloat(d4(1)), GetFacingFromLocation(GetLocation(oCaster)), 0.0));
        }

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE | OBJECT_TYPE_AREA_OF_EFFECT);

    while (GetIsObjectValid(oTarget) && nBlow != 1)
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
        {
            sAOETag = GetTag(oTarget);
            if ( sAOETag == "VFX_PER_FOGACID" ||
                 sAOETag == "VFX_PER_FOGKILL" ||
                 sAOETag == "VFX_PER_FOGBEWILDERMENT" ||
                 sAOETag == "VFX_PER_FOGSTINK" ||
                 sAOETag == "VFX_PER_FOGFIRE" ||
                 sAOETag == "VFX_PER_FOGMIND" ||
                 sAOETag == "VFX_PER_CREEPING_DOOM")
            {
                DestroyObject(oTarget);
            }
        }
        else
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;

                if (GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
                {
                    if (GetLocked(oTarget) == FALSE)
                    {
                        if (GetIsOpen(oTarget) == FALSE)
                        {
                            AssignCommand(oTarget, ActionOpenDoor(oTarget));
                        }
                        else
                            AssignCommand(oTarget, ActionCloseDoor(oTarget));
                    }
                }
                if(!MyResistSpell(OBJECT_SELF, oTarget) && !/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC()))
                {

                    effect eKnockdown = EffectKnockdown();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oTarget, RoundsToSeconds(3));

                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));

                 }
             }
        }

       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE |OBJECT_TYPE_AREA_OF_EFFECT);
    }

}



