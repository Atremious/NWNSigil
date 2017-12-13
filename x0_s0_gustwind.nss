#include "inc_spellfuncs"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }



    if (GetHasStringOnEquippedItems(OBJECT_SELF, "MOD_GUST"))
    {
        DoGustOfWind(GetSpellTargetLocation(), 1);
    }

    else
    {
        DoGustOfWind(GetSpellTargetLocation());
    }
}
