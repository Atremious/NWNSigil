void main()
{
    object oPC = OBJECT_SELF;
    object oMember;

    if(oPC == GetFactionLeader(oPC))
    {
        oMember = GetFirstFactionMember(oPC);
        while(GetIsObjectValid(oMember) && oMember != oPC)
        {
            RemoveFromParty(oMember);
            oMember = GetNextFactionMember(oPC);
        }
    }

    SendMessageToPC(oPC, "You've disbanded your party.");
}

