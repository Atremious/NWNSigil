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

    ToggleSetting(oPC, "Hide Helm");

        if(GetSettingOn(oPC, "Hide Helm"))
        {
            SetHiddenWhenEquipped(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC), TRUE);
        }

        if(!GetSettingOn(oPC, "Hide Helm"))
        {
            SetHiddenWhenEquipped(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC), FALSE);
        }
}
