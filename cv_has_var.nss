int StartingConditional()
{
    object oPC   = GetPCSpeaker();
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    string sVar = GetLocalString(OBJECT_SELF, "VAR");

    if(GetLocalInt(oHide, sVar))
    {
        if(GetLocalInt(OBJECT_SELF, "VAR_DELETE"))
        {
            DeleteLocalInt(oHide, sVar);
        }
        return TRUE;
    }

    else
    {
        return FALSE;
    }
}
