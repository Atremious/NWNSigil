void main()
{
    object oPC     = OBJECT_SELF;
    object oTarget = GetLocalObject(oPC, "TELL_TARGET");

    if(oPC == GetFactionLeader(oTarget))
    {
        RemoveFromParty(oTarget);
    }

    DeleteLocalObject(oPC, "InvitedBy");
}

