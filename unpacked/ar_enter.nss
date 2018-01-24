#include "inc_text"

void main()
{
    object oPC    = GetEnteringObject();
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
    object oArea  = OBJECT_SELF;

    int nPlayers  = GetLocalInt(oArea, "PLAYER_COUNT");

    if(GetIsPC(oPC))
    {
        SetLocalLocation(oHide, "LOCATION", GetLocation(oPC));
        SetLocalInt(oArea, "PLAYER_COUNT", nPlayers++);

        if(GetXP(oPC) < 3000)
        {
            ExecuteScript("ar_enter_newpc", oPC);
        }


        object oNPC;
        if(GetLocalInt(oArea, "ACTIVE") == 0)
        {
            SetLocalInt(oArea, "ACTIVE", 1);

            oNPC = GetFirstObjectInArea(oArea);
            while(GetIsObjectValid(oNPC) && GetObjectType(oNPC) == OBJECT_TYPE_CREATURE)
            {
                SetAILevel(oNPC, AI_LEVEL_DEFAULT);
                oNPC = GetNextObjectInArea(oArea);
            }
        }

    }


}
