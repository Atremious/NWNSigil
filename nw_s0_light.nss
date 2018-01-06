//::///////////////////////////////////////////////
//:: Light
//:: NW_S0_Light.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Applies a light source to the target for
    1 hour per level

    XP2
    If cast on an item, item will get temporary
    property "light" for the duration of the spell
    Brightness on an item is lower than on the
    continual light version.

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 15, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
//:: Added XP2 cast on item code: Georg Z, 2003-06-05
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }


    object oTarget = GetSpellTargetObject();
    object oPC     = OBJECT_SELF;
    object oHide   = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    int nDuration;
    int nMetaMagic;
    int nLight   = VFX_DUR_LIGHT_WHITE_20;
    int nLightIP = IP_CONST_LIGHTCOLOR_WHITE;

    if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM && ! CIGetIsCraftFeatBaseItem(oTarget))
    {

        if (!IPGetIsItemEquipable(oTarget))
        {
             FloatingTextStrRefOnCreature(83326,OBJECT_SELF);
            return;
        }

        if(GetLocalInt(oHide, "LIGHT_OVERRIDE_IT"))
        {
            nLightIP = GetLocalInt(oHide, "LIGHT_OVERRIDE_IT");
        }

        itemproperty ip = ItemPropertyLight (IP_CONST_LIGHTBRIGHTNESS_NORMAL, nLightIP);

        if (GetItemHasItemProperty(oTarget, ITEM_PROPERTY_LIGHT))
        {
            IPRemoveMatchingItemProperties(oTarget,ITEM_PROPERTY_LIGHT,DURATION_TYPE_TEMPORARY);
        }

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }

       // AddItemProperty(DURATION_TYPE_TEMPORARY,ip,oTarget,HoursToSeconds(nDuration));
    }

    else
    {

        if(GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL"))
        {
            nLight = GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL");
        }

        effect eVis = EffectVisualEffect(nLight);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eVis, eDur);

        nDuration = GetCasterLevel(OBJECT_SELF);
        nMetaMagic = GetMetaMagicFeat();
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2; //Duration is +100%
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LIGHT, FALSE));

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
    }

}

