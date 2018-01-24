#include "x2_inc_switches"
#include "x3_inc_horse"
#include "inc_gen"

void main()
{

    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();

    if(GetBaseItemType(oItem) == BASE_ITEM_CLOAK)
    {
        if(GetSettingOn(oPC, "Hide Cloak"))
        {
            SetHiddenWhenEquipped(oItem, TRUE);
        }

        if(!GetSettingOn(oPC, "Hide Cloak"))
        {
            SetHiddenWhenEquipped(oItem, FALSE);
        }
    }

    if(GetBaseItemType(oItem) == BASE_ITEM_HELMET)
    {
        if(GetSettingOn(oPC, "Hide Helm"))
        {
            SetHiddenWhenEquipped(oItem, TRUE);
        }

        if(!GetSettingOn(oPC, "Hide Helm"))
        {
            SetHiddenWhenEquipped(oItem, FALSE);
        }
    }

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        SetLocalInt(oPC,"bX3_M_ARCHERY",TRUE);
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }

    // -------------------------------------------------------------------------
    // Generic Item Script Execution Code
    // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // it will execute a script that has the same name as the item's tag
    // inside this script you can manage scripts for all events by checking against
    // GetUserDefinedItemEventNumber(). See x2_it_example.nss
    // -------------------------------------------------------------------------
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_EQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }
}
