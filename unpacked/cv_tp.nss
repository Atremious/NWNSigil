void main()
{
    string sDest = GetLocalString(OBJECT_SELF, "DEST");
    object oPC = GetPCSpeaker();

    object oTarget = GetObjectByTag(sDest);

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToObject(oTarget));
}
