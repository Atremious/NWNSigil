void main()
{
    object oPC = OBJECT_SELF;

    string sDest;

    if(GetGoodEvilValue(oPC) >= 70) //good
    {
        sDest = "LIONST_WP";
    }

    if(GetGoodEvilValue(oPC) >= 31 && GetGoodEvilValue(oPC) <= 69) //neutral
    {
        sDest = "LIONST_WP";
    }

    if(GetGoodEvilValue(oPC) <= 30) //evil
    {
        sDest = "LIONST_WP";
    }


    SetXP(oPC, GetXP(oPC) + 3000);

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToObject(GetObjectByTag(sDest)));
}
