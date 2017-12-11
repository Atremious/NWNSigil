//When a PC uses this placeable, it will be teleported to the object/waypoint with the tag of
//The local string "DEST" set on this placeable.
//To make an item requirement to use this placeable, add the local string "ITEM_RESTRICT", and set
//Its value to be the tag of the item required.
//The local string "ITEM_RESTRICT_MSG" will be sent to the pc if they don't have the item.
void main()
{

    string sDest = GetLocalString(OBJECT_SELF, "DEST");
    string sItem = GetLocalString(OBJECT_SELF, "ITEM_RESTRICT");

    object oPC = GetLastUsedBy();
    object oTarget = GetObjectByTag(sDest);

    if(sDest == "")//We're only going somewhere if we have a destination planned.
    {
        return;//No destination? TURN AROUND.
    }

    if(sItem != "")
    {
        if(GetItemPossessedBy(oPC, sItem) != OBJECT_INVALID)
        {
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionJumpToObject(oTarget));
        }

        else
        {
            SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "ITEM_RESTRICT_MSG"));
        }

    }

    else
    {

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToObject(oTarget));

    }
}

