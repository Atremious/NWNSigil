#include "x2_inc_switches"
#include "x2_inc_itemprop"
/*
When this item is used, it copies all of the itemp properties from the defined template onto the target.
The variable TEMPLATE_HOLDER is the tag of the holder of the template item.
The variable TEMPLATE is the tag of the template item.
The variable CHARGE_COST is the amount of charges the gem costs to slot.
The variable ITEM_RESTICT is a string determining the type of item the gem can be put into to...
"RANGED", "MELEE", "PROJECTILE", "EQUIPABLE" are all valid values.
EQUIPABLE being anything but weapons and projectiles; cloaks, belts, armor, shield, etc.
*/
void main()
{

    object oPC   = GetItemActivator();
    object oGem  = GetItemActivated();
    object oItem = GetItemActivatedTarget();

    int nEvent   = GetUserDefinedItemEventNumber();
    int nGemCost = GetLocalInt(oGem, "CHARGE_COST");
    int nSlots   = GetItemCharges(oItem);

    int nSlotsFinal = nSlots - nGemCost;
    int nErrorCount;

    string sError;
    string sID             = GetLocalString(oGem, "ID");
    string sTemplate       = GetLocalString(oGem, "TEMPLATE");
    string sTemplateHolder = GetLocalString(oGem, "TEMPLATE_HOLDER");
    string sItemRestrict   = GetStringUpperCase(GetLocalString(oGem, "ITEM_RESTRICT"));

    if(nEvent == X2_ITEM_EVENT_ACTIVATE)
    {
        object oTemplate = GetItemPossessedBy(GetObjectByTag(sTemplateHolder), sTemplate);

        if(oItem == oPC)
        {
            object oDesc = CopyItem(oTemplate, oPC);

            DelayCommand(0.2,AssignCommand(oPC, ClearAllActions()));
            DelayCommand(0.5, AssignCommand(oPC, ActionExamine(oDesc)));
            DelayCommand(1.5, DestroyObject(oDesc));
            return;
        }

        if(nSlotsFinal < 1)
        {
            sError = sError + "This item doesn't have enough charges to be slotted with any additional gems. Items cannot go below 1 charge.";
            nErrorCount++;
        }

        if(GetLocalString(oItem, sID) != "")
        {
           sError = sError + GetName(oGem) + " has already been slotted into this item." + "\n\n";
           nErrorCount++;
        }

        if(!GetIsObjectValid(oTemplate))
        {
           sError = sError + "Item property cannot be added. Report this gem as being faulty.";
           sError = sError + GetLocalString(oGem, "TEMPLATE_HOLDER") + " : " + GetLocalString(oGem, "TEMPLATE");
           nErrorCount++;
        }

        if(sItemRestrict == "MELEE" && !IPGetIsMeleeWeapon(oItem))//melee weapon only
        {
            sError = sError + "Item propery cannot be added. This gem can only be slotted into melee weapons.";
            nErrorCount++;
        }

        if(sItemRestrict == "RANGED" && !IPGetIsRangedWeapon(oItem))//ranged weapon only
        {
            sError = sError + "Item propery cannot be added. This gem can only be slotted into ranged weapons.";
            nErrorCount++;
        }

        if(sItemRestrict == "PROJECTILE" && !IPGetIsProjectile(oItem))//projectile only
        {
            sError = sError + "Item propery cannot be added. This gem can only be slotted into projectiles.";
            nErrorCount++;
        }

        if(sItemRestrict == "EQUIPABLE" && IPGetIsItemEquipable(oItem))//non-weapon equipable only
        {
            if(IPGetIsMeleeWeapon(oItem) || IPGetIsProjectile(oItem) || IPGetIsRangedWeapon(oItem))
            {
                sError = sError + "Item propery cannot be added. This gem can only be slotted into non-weapon equipables; cloak, belt, helmet, etc.";
                nErrorCount++;
            }
        }

        if(sItemRestrict == "EQUIPABLE" && !IPGetIsItemEquipable(oItem))//non-weapon equipable only
        {
            sError = sError + "Item propery cannot be added. This gem can only be slotted into non-weapon equipables; cloak, belt, helmet, etc.";
            nErrorCount++;
        }

        if(nErrorCount > 0)
        {
            SendMessageToPC(oPC, sError);
            return; //If any of the above errors occur..  don't proceed.
        }

        if(GetIsObjectValid(oTemplate) && nSlotsFinal >= 1 && GetLocalString(oItem, sTemplate) == "")
        {
          SetItemCharges(oItem, nSlotsFinal);
          SetLocalString(oItem, sID, "SLOTTED");

            itemproperty ipTemplate = GetFirstItemProperty(oTemplate);

            while(GetIsItemPropertyValid(ipTemplate))
           {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipTemplate, oItem);
                ipTemplate = GetNextItemProperty(oTemplate);
            }

          SendMessageToPC(oPC, "You've successfully slotted " + GetName(oGem) + " into " + GetName(oItem) + ".");
          SendMessageToPC(oPC, GetName(oItem) + " has " + IntToString(GetItemCharges(oItem)) + " charges remaining that can be used to slot gems.");
        }

       if(GetItemStackSize(oGem) > 1)
       {
            SetItemStackSize(oGem, GetItemStackSize(oGem) - 1);
       }

       else
       {
            DestroyObject(oGem);
       }
    }
}

