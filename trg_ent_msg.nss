void main()
{
    object oPC = GetEnteringObject();

    if(GetLocalString(OBJECT_SELF, "MSG") != "")
    {
        SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "MSG"));
    }
}
