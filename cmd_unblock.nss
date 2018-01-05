void main()
{
    object oPC     = OBJECT_SELF;
    object oTarget = GetLocalObject(oPC, "TELL_TARGET");

    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    DeleteLocalInt(oHide, "TL_" + GetPCPlayerName(oTarget));

    SendMessageToPC(oPC, "You have unblocked tells from the Player Name " + GetPCPlayerName(oTarget) +
    ". You will now be able to recieve tells from them.");
}
