void main()
{
    object oPC   = GetEnteringObject();
    object oSelf = OBJECT_SELF;

    string sCheck = GetLocalString(oSelf, "NPC_TAG");
    string sWP    = GetLocalString(oSelf, "WP_TAG");

    object oWP = GetObjectByTag(sWP);

    if(GetIsPC(oPC) || GetIsDM(oPC))
    {
        return;
    }

    if(GetTag(oPC) == sCheck)
    {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oWP));
    }
}
