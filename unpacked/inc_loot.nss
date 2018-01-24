const int LOOT_MODIFIER = 0; //This is added to the loot's chance of spawning.

/*::::::::::::::::/*
oGenerateIn  | Object to generate items onto.
sContainer   | Template tag of the container to generate from.
Generates items from the container by the tag of sContainer. See container comments
for more information on spawn chance.
/*::::::::::::::::*/
void GenerateLoot(object oGenerateIn, string sContainer);
void GenerateLoot(object oGenerateIn, string sContainer)
{

    object oContainer = GetObjectByTag(sContainer);
    int nCount;

    int nLimit = GetLocalInt(oContainer, "LOOT_SPAWN_LIMIT");

    if(nLimit <= 0)
    {
        nLimit = 3; //Standard loot limit.
    }

    if(GetIsObjectValid(oContainer))
    {
        object oItem = GetFirstItemInInventory(oContainer);

        while(GetIsObjectValid(oItem))
        {
            if(Random(1001)<= (GetLocalInt(oItem, "SPAWN_CHANCE") + LOOT_MODIFIER) && nCount <= nLimit)
            {
                CopyItem(oItem, oGenerateIn, TRUE);
                nCount++;
            }

            oItem = GetNextItemInInventory(oContainer);
        }

    }

}


/*::::::::::::::::/*
oGenerateIn  | Object to generate gold onto.
nBase        | The base amount of gold to always generate.
nRandom      | If nRandom is > 0, an amount of gold between 0 and nRandom will be added to oGenerateIn's
inventory.

Generates gold on a creature.
/*::::::::::::::::*/
void GenerateGold(object oGenerateIn, int nBase = 0, int nRandom = 0);
void GenerateGold(object oGenerateIn, int nBase = 0, int nRandom = 0)
{
    int nGive = nBase + Random(nRandom);

     CreateItemOnObject("nw_it_gold001", oGenerateIn, nGive);

}
