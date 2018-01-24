#include "inc_text"

void main()
{
    object oPC   = OBJECT_SELF;
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    int nLight = GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL");
    int nLightIP = GetLocalInt(oHide, "LIGHT_OVERRIDE_IT");

    if(!GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") || GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") == VFX_DUR_LIGHT_WHITE_10)
    {
        SetLocalInt(oHide, "LIGHT_OVERRIDE_SPL", VFX_DUR_LIGHT_BLUE_10);
        SetLocalInt(oHide, "LIGHT_OVERRIDE_IT", IP_CONST_LIGHTCOLOR_BLUE);

        SendMessageToPC(oPC, "Your Light spell will now produce a blue light.");
        return;
    }

    if(GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") == VFX_DUR_LIGHT_BLUE_10)
    {
        SetLocalInt(oHide, "LIGHT_OVERRIDE_SPL", VFX_DUR_LIGHT_ORANGE_10);
        SetLocalInt(oHide, "LIGHT_OVERRIDE_IT", IP_CONST_LIGHTCOLOR_ORANGE);

        SendMessageToPC(oPC, "Your Light spell will now produce an orange light.");
        return;
    }

    if(GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") == VFX_DUR_LIGHT_ORANGE_10)
    {
        SetLocalInt(oHide, "LIGHT_OVERRIDE_SPL", VFX_DUR_LIGHT_PURPLE_10);
        SetLocalInt(oHide, "LIGHT_OVERRIDE_IT", IP_CONST_LIGHTCOLOR_PURPLE);

        SendMessageToPC(oPC, "Your Light spell will now produce a purple light.");
        return;
    }

    if(GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") == VFX_DUR_LIGHT_PURPLE_10)
    {
        SetLocalInt(oHide, "LIGHT_OVERRIDE_SPL", VFX_DUR_LIGHT_RED_10);
        SetLocalInt(oHide, "LIGHT_OVERRIDE_IT", IP_CONST_LIGHTCOLOR_RED);

        SendMessageToPC(oPC, "Your Light spell will now produce a red light.");
        return;
    }

    if(GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") == VFX_DUR_LIGHT_RED_10)
    {
        SetLocalInt(oHide, "LIGHT_OVERRIDE_SPL", VFX_DUR_LIGHT_YELLOW_10);
        SetLocalInt(oHide, "LIGHT_OVERRIDE_IT", IP_CONST_LIGHTCOLOR_YELLOW);

        SendMessageToPC(oPC, "Your Light spell will now produce a yellow light.");
        return;
    }

    if(GetLocalInt(oHide, "LIGHT_OVERRIDE_SPL") == VFX_DUR_LIGHT_YELLOW_10)
    {
        SetLocalInt(oHide, "LIGHT_OVERRIDE_SPL", VFX_DUR_LIGHT_WHITE_10);
        SetLocalInt(oHide, "LIGHT_OVERRIDE_IT", IP_CONST_LIGHTCOLOR_WHITE);

        SendMessageToPC(oPC, "Your Light spell will now produce a white light.");
        return;
    }
}
