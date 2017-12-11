void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC))
    {
        if(GetXP(oPC) < 3000)
        {
            ExecuteScript("ar_enter_newpc", oPC);
        }

    }
}
