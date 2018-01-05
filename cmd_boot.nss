void main()
{
    object oPC     = OBJECT_SELF;
    object oTarget = GetLocalObject(oPC, "TELL_TARGET");

    string sMsg    = GetStringLowerCase(GetLocalString(oPC, "LAST_SAID"));

    if(GetIsDM(oPC))
    {
        if(sMsg == "-boot")
        {
            BootPC(oTarget);
            SendMessageToPC(oPC, "You've just booted " + GetName(oPC) + "(" +
            GetPCPlayerName(oPC) + ") [" + GetPCPublicCDKey(oPC) + "].");
        }
    }

}

