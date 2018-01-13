#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "x3_inc_horse"
#include "inc_gen"
#include "inc_loot"
void main()
{
    float MOB_LOOT_TIME = 120.0; //The time it takes for dropped loot to expire.

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    //Loot Generation
    if(Random(1001)<= GetLocalInt(OBJECT_SELF, "LOOT_CACHE_CHANCE"))
    {
        object oCache = CreateObject(OBJECT_TYPE_PLACEABLE, "PLC_MOBLOOT", GetLocation(OBJECT_SELF));

        SetLocalString(oCache, "LOOT_CONTAINER_TAG", GetLocalString(OBJECT_SELF, "LOOT_CONTAINER_TAG"));
        SetLocalInt(oCache, "LOOT_GP_BASE", GetLocalInt(OBJECT_SELF, "LOOT_GP_BASE"));
        SetLocalInt(oCache, "LOOT_GP_RANDOM", GetLocalInt(OBJECT_SELF, "LOOT_GP_RANDOM"));

        SetName(oCache, GetName(OBJECT_SELF));
        SetDescription(oCache, GetName(OBJECT_SELF));

        DelayCommand(MOB_LOOT_TIME, DestroyObject(oCache));
    }

    if(GetLocalInt(OBJECT_SELF, "RECREATE"))
    {
        RecreateObject(OBJECT_SELF);
    }

}
