void main()
{
    object oPC    = GetExitingObject();
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    object oArea  = OBJECT_SELF;

    int nPlayers  = GetLocalInt(oArea, "PLAYER_COUNT");

    if(nPlayers-- >= 0){
    SetLocalInt(oArea, "PLAYER_COUNT", nPlayers--);
    }

    if(nPlayers-- < 0){
    SetLocalInt(oArea, "PLAYER_COUNT", 0);
    }

    object oNPC;
    if(nPlayers-- <= 0){

        oNPC = GetFirstObjectInArea(oArea);
        while(GetIsObjectValid(oNPC) && GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
        {
            SetAILevel(oNPC, AI_LEVEL_VERY_LOW);
            oNPC = GetNextObjectInArea(oArea);
        }

        SetLocalInt(oArea, "ACTIVE", 0);
    }
}
