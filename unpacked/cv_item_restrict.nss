//Use this script to restrict text to appear by item.
//Use the String variable "ITEM_RESTRICT", and set its value
//To the tag of the item you wish the text to appear for.
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sItem = GetLocalString(OBJECT_SELF, "ITEM_RESTRICT");

    if ( GetItemPossessedBy(oPC, sItem) == OBJECT_INVALID )
        return FALSE;

    return TRUE;
}

