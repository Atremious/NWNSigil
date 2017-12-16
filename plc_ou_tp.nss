void main()
{

    string sDest = GetLocalString(OBJECT_SELF, "DEST");
    string sItem = GetLocalString(OBJECT_SELF, "ITEM_RESTRICT");

    object oPC = GetLastUsedBy();
    object oTarget = GetObjectByTag(sDest);

    int nRandom = GetLocalInt(OBJECT_SELF, "RANDOM");
    int nGenerate = GetLocalInt(OBJECT_SELF, "GENERATE");

    float fDur = GetLocalFloat(OBJECT_SELF, "RANDOM_DUR");


    if(nRandom == 1)//Random portal script starts here.
    {

        if(nGenerate != 1) //0 = generate a random location, 1 = don't generate
        {
            SetLocalInt(OBJECT_SELF, "GENERATE", 1);
            DelayCommand(fDur, SetLocalInt(OBJECT_SELF, "GENERATE", 0));

	    //Generate new portal location here

        }

        if(sDest == "")//We're only going somewhere if we have a destination planned.
        {
            return;//No destination? TURN AROUND.
        }

        if(sItem != "")
        {
            if(GetItemPossessedBy(oPC, sItem) != OBJECT_INVALID)
            {
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionJumpToObject(oTarget));
            }

            else
            {
                SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "ITEM_RESTRICT_MSG"));
            }

        }

        else
        {

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oTarget));

        }

    }



    if(nRandom != 1)//Not random portal script starts here.
    {

        if(sDest == "")//We're only going somewhere if we have a destination planned.
        {
            return;//No destination? TURN AROUND.
        }

        if(sItem != "")
        {
            if(GetItemPossessedBy(oPC, sItem) != OBJECT_INVALID)
            {
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oPC, ActionJumpToObject(oTarget));
            }

            else
            {
                SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "ITEM_RESTRICT_MSG"));
            }

        }

        else
        {

        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionJumpToObject(oTarget));

        }
    }
}

