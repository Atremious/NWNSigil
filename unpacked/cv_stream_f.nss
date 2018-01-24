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

    SetLocalString(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), "STREAM", "FEY");
    SendMessageToPC(oPC, "Your stream has been set to Fey.");
}
