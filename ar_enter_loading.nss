void main()
{
    object oPC    = GetEnteringObject();
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    object oArea  = OBJECT_SELF;

    location lLoc = GetLocalLocation(oHide, "LOCATION");

    if(GetIsPC(oPC))
    {
        if(GetXP(oPC) < 3000)
        {
            ExecuteScript("ar_enter_newpc", oPC);
        }

        if(GetXP(oPC) > 3000)
        {
            AssignCommand(oPC, ClearAllActions());
            AssignCommand(oPC, ActionJumpToLocation(lLoc));
        }

    }
}
