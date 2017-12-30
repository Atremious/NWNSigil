void main()
{
    object oPC = GetLastUsedBy();
    string sItem = GetLocalString(OBJECT_SELF, "ITEM_SPAWN");

    if(GetLocalString(OBJECT_SELF, GetName(oPC)) == "")
    {
        SetLocalString(OBJECT_SELF, GetName(oPC), "USED");
        CreateItemOnObject(sItem, oPC);
    }
}
