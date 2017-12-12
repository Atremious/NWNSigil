/*::::::::::::::::/*
Fireball: 3rd Circle, Wizard & Sorcerer
Deals 1d6/level, up to 10d6 maximum damage to foes in the area of effect.
If cast upon Grease, creates a Wall of Fire.
/*::::::::::::::::*/
#include "inc_spellfuncs"
void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }

    //Do Fireball at the spell's target.
    location lBase = GetSpellTargetLocation();
    DoFireball(lBase);

    //If has an item with the fireball amount passive increase, do two extra explosions at random locations.
    if (GetHasStringOnEquippedItems(OBJECT_SELF, "MOD_EXTRA_FIREBALL"))
   {
        DoFireball(GenerateNewLocationFromLocation(lBase, 2.0 + IntToFloat(d4(1)), IntToFloat(Random(360)), 0.0));
        DoFireball(GenerateNewLocationFromLocation(lBase, 2.0 + IntToFloat(d4(1)), IntToFloat(Random(360)), 0.0));
   }

}

