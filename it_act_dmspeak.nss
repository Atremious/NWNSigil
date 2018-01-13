void main()
{
    object oPC     = GetItemActivator();
    object oItem   = GetItemActivated();
    object oTarget = GetItemActivatedTarget();

    if(!GetIsPC(oTarget) && !GetIsDM(oTarget))
    {
        SetLocalObject(oPC, "DM_TARGET", oTarget);
    }

    SendMessageToPC(oPC, "All messages sent with the prefix '!' will be spoken through " + GetName(oTarget) + ".");
}
