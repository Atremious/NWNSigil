void main()
{
    object oPC = GetEnteringObject();

    if(GetLocalString(OBJECT_SELF, "MSG") != "" && !GetLocalInt(OBJECT_SELF, GetName(oPC)))
    {
        SetLocalInt(OBJECT_SELF, GetName(oPC), 1);
        SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "MSG"));

        DelayCommand(60.0, DeleteLocalInt(OBJECT_SELF, GetName(oPC)));
    }
}
