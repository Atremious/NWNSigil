//::///////////////////////////////////////////////
//:: Summon Monster II
//:: NW_S0_Summon2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a dire boar to fight for the character
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12 , 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 25, 2001
#include "x2_inc_spellhook"
void main()
{


    /*
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more

    */

        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }

    // End of Spell Cast Hook



    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);

    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    effect eSummon   = EffectSummonCreature("cr_summon_001");

    string sStream   = GetLocalString(GetItemInSlot(INVENTORY_SLOT_CARMOUR, OBJECT_SELF), "STREAM");

    //Determine summon stream.
    if(sStream == "MAGICAL_BEAST")
    {
        eSummon = EffectSummonCreature("cr_summon_001");
    }

    if(sStream == "FEY")
    {
        eSummon = EffectSummonCreature("cr_summon_004");
    }

    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER))
    {
        //eSummon = EffectSummonCreature("NW_S_WOLFDIRE");
    }
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
}
