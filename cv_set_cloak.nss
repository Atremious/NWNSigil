#include "inc_gen"
void main()
{
    object oPC;

    if(GetPCSpeaker() == OBJECT_INVALID)
    {
        oPC = OBJECT_SELF;
    }

    else
    {
        oPC = GetPCSpeaker();;
    }

    ToggleSetting(oPC, "Hide Cloak");


        if(GetSettingOn(oPC, "Hide Cloak"))
        {
            SetHiddenWhenEquipped(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC), TRUE);
        }

        if(!GetSettingOn(oPC, "Hide Cloak"))
        {
            SetHiddenWhenEquipped(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC), FALSE);
        }
}
