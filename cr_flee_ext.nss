//Extended script for fleeing
void main()
{
    object oSelf = OBJECT_SELF;
    object oPC   = GetLocalObject(oSelf, "FLEE_FROM");

    if(GetDistanceBetween(oPC, oSelf) < 12.0)
    {
        ActionMoveAwayFromObject(oPC, TRUE, 35.0);
        DelayCommand(6.0, ExecuteScript("cr_flee_ext", oSelf));
    }

}
