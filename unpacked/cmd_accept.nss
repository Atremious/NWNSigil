void main()
{
    object oPC     = OBJECT_SELF;
    object oFriend = GetLocalObject(oPC, "TELL_TARGET");

    AddToParty(oPC, GetFactionLeader(oFriend));

    DeleteLocalObject(oPC, "InvitedBy");
}

