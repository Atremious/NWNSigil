/*::::::::::::::::/*
Wall of FIre: 4th Circle, Wizard & Sorcerer
              5th Circle, Druid
This spell creates a curtain of fire that deals 4d6 points of
fire damage to any creature that attempts to pass through it.
/*::::::::::::::::*/
#include "inc_spellfuncs"

void main()
{
    if (!X2PreSpellCastCode())
    {

        return;
    }

    DoWallOfFire(GetSpellTargetLocation());
}
