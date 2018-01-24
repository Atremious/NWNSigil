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

    SetLocalString(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), "STREAM", "MAGICAL_BEAST");
    SendMessageToPC(oPC, "Your stream has been set to Magical Beast.");
}
