void main()
{
    object oPC = GetPCSpeaker();

    int nCount = GetLocalInt(OBJECT_SELF, "ITEM_GIVE_COUNT");

    string sItem = GetLocalString(OBJECT_SELF, "ITEM_GIVE");

    CreateItemOnObject(sItem, oPC, nCount);
}
