//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

effect SetSummonEffect(int nSpellID, object oTarget);

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
    int nSpellID = GetSpellId();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = 24;
    if(nDuration == 1)
    {
        nDuration = 2;
    }
    effect eSummon = SetSummonEffect(nSpellID, OBJECT_SELF);

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}


effect SetSummonEffect(int nSpellID, object oTarget = OBJECT_SELF)
{
    int nFNF_Effect;
    int nRoll = d3();
    string sSummon;
    string sStream;
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, OBJECT_SELF);

        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
             sSummon = "cr_sum_jaculi";
             sStream = GetLocalString(oHide, "SUM_1");
             nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;

           if(sStream!= "")
           {
             sSummon = sStream;
           }

            if(GetLocalInt(oHide, "SUM_1_VFX"))
            {
                nFNF_Effect = GetLocalInt(oHide, "SUM_1_VFX");
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
             sSummon = "cr_sum_worg";
             sStream = GetLocalString(oHide, "SUM_2");
             nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;

           if(sStream!= "")
           {
             sSummon = sStream;
           }

            if(GetLocalInt(oHide, "SUM_2_VFX"))
            {
                nFNF_Effect = GetLocalInt(oHide, "SUM_2_VFX");
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
             sSummon = "cr_sum_gspider";
             sStream = GetLocalString(oHide, "SUM_3");
             nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;

           if(sStream!= "")
           {
             sSummon = sStream;
           }

            if(GetLocalInt(oHide, "SUM_3_VFX"))
            {
                nFNF_Effect = GetLocalInt(oHide, "SUM_3_VFX");
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
             sSummon = "cr_sum_gbear";
             sStream = GetLocalString(oHide, "SUM_4");
             nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;

           if(sStream!= "")
           {
             sSummon = sStream;
           }
            if(GetLocalInt(oHide, "SUM_4_VFX"))
            {
                nFNF_Effect = GetLocalInt(oHide, "SUM_4_VFX");
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }

    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}

