void main()
{
    object oPC = OBJECT_SELF;

    string sSaid  = GetLocalString(oPC, "LAST_SAID");
    string sEmote = GetStringLowerCase(GetSubString(sSaid, 1, GetStringLength(sSaid)));

    int nEmote;
    float fDur;
    float fSpeed;

    if(GetSubString(sEmote, 0, 3) == "bow")
    {
        nEmote = ANIMATION_FIREFORGET_BOW;
        fSpeed = 1.0;
    }

    if(GetSubString(sEmote, 0, 4) == "cast")
    {
        nEmote = ANIMATION_LOOPING_CONJURE2;
        fSpeed = 1.0;
        fDur   = 3600.0;
    }

    if(GetSubString(sEmote, 0, 7) == "conjure")
    {
        nEmote = ANIMATION_LOOPING_CONJURE1;
        fSpeed = 1.0;
        fDur   = 3600.0;
    }

    if(GetSubString(sEmote, 0, 5) == "drink")
    {
        nEmote = ANIMATION_FIREFORGET_DRINK;
        fSpeed = 1.0;
    }

    if(GetSubString(sEmote, 0, 3) == "lie")
    {
        nEmote = ANIMATION_LOOPING_DEAD_BACK;
        fSpeed = 1.0;
        fDur   = 3600.0;
    }

    if(GetSubString(sEmote, 0, 8) == "meditate")
    {
        nEmote = ANIMATION_LOOPING_MEDITATE;
        fSpeed = 1.0;
        fDur   = 3600.0;
    }

    if(GetSubString(sEmote, 0, 3) == "sit")
    {
        nEmote = ANIMATION_LOOPING_SIT_CROSS;
        fSpeed = 1.0;
        fDur   = 3600.0;
    }

    if(GetSubString(sEmote, 0, 4) == "read")
    {
        nEmote = ANIMATION_FIREFORGET_READ;
        fSpeed = 1.0;
    }

    if(GetSubString(sEmote, 0, 7) == "worship")
    {
        nEmote = ANIMATION_LOOPING_WORSHIP;
        fSpeed = 1.0;
        fDur   = 3600.0;
    }

    AssignCommand(oPC, PlayAnimation(nEmote, fSpeed, fDur));
}
