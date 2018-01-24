void main()
{
    object oPC;

    if(GetPCSpeaker() == OBJECT_INVALID)
    {
        oPC = OBJECT_SELF;
    }

    else
    {
        oPC = GetPCSpeaker();;
    }

    SetLocalInt(oPC, "RestConvDisable", 1);
    DelayCommand(1.0, SetLocalInt(oPC, "RestConvDisable", 0));

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionRest());
}
