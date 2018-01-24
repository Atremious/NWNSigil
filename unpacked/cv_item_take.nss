    void main()
    {
        object oPC = GetPCSpeaker();

        int nXP = GetLocalInt(OBJECT_SELF, "XP_PER_ITEM");
        int nGP = GetLocalInt(OBJECT_SELF, "GP_PER_ITEM");
        int nCount;

        string sItem = GetLocalString(OBJECT_SELF, "ITEM_RESTRICT");

        object oItem = GetFirstItemInInventory(oPC);
        while ( GetTag(oItem) == sItem )
        {
            DestroyObject(oItem);
            nCount++;
            oItem = GetNextItemInInventory(oPC);
        }

        int nGPOverride = GetLocalInt(OBJECT_SELF, "ITEM_GP_OVERRIDE");
        int nXPOverride = GetLocalInt(OBJECT_SELF, "ITEM_XP_OVERRIDE");

        if(nGPOverride != 0)
        {
            nGP = nGPOverride;
        }

        if(nXPOverride != 0)
        {
            nXP = nXPOverride;
        }

        if(nXP > 0)
        {
            GiveXPToCreature(oPC, nXP*nCount);
        }

        if(nGP > 0)
        {
            GiveGoldToCreature(oPC, nGP*nCount);
        }
    }
