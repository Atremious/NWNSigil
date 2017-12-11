void main()
{
    SetLocalInt(GetPCSpeaker(), "COL_CHAN", ITEM_APPR_ARMOR_COLOR_CLOTH1);


        object oPC = GetPCSpeaker();
        int nColor = StringToInt(GetLocalString(oPC, "LAST_SAID"));

        int nColorType = GetLocalInt(oPC, "COL_CHAN");
        int nModel = GetLocalInt(oPC, "COL_MDL");

        int nEq = ITEM_APPR_ARMOR_NUM_COLORS + (nModel * ITEM_APPR_ARMOR_NUM_COLORS) + nColorType;

        object oNew = CopyItemAndModify(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC),ITEM_APPR_TYPE_ARMOR_COLOR, nEq , nColor, TRUE);

        DestroyObject(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));

        AssignCommand(oPC, ActionEquipItem(oNew, INVENTORY_SLOT_CHEST));
        AssignCommand(oPC, SpeakString(IntToString(nColor)));
}
