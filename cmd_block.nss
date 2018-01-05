void main()
{
    object oPC     = OBJECT_SELF;
    object oTarget = GetLocalObject(oPC, "TELL_TARGET");

    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    SetLocalInt(oHide, "TL_" + GetPCPlayerName(oTarget), 1);

    SendMessageToPC(oPC, "You have blocked tells from the Player Name " + GetPCPlayerName(oTarget) +
    ". You will no longer be able to recieve tells from them.");
}
