int StartingConditional()
{
    object oPC = GetPCSpeaker();


    if ( GetRacialType(oPC) != GetLocalInt(OBJECT_SELF, "RACE_RESTRICT" ))
        return FALSE;

    return TRUE;
}

