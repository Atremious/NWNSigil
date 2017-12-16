void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();

    string sSum = GetLocalString(oItem, "SUM");
    string sVal = GetLocalString(oItem, "SUM_VAL");

    SetLocalString(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), sSum, sVal);

    if(GetLocalString(oItem, "MSG") != "")
    {
        SendMessageToPC(oPC, GetLocalString(oItem, "MSG"));
    }

    if(GetLocalInt(oItem, "SUM_VFX") > 0)
    {
        SetLocalInt(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), sSum + "_VFX", GetLocalInt(oItem, "SUM_VFX"));
    }
}
