/*::::::::::::::::/*
Grease: 1st Circle, Bard, Druid, Ranger, Sorcerer, Wizard
A churning field of oil and grease fills the target area,
causing all within to either fall down or move at a reduced speed.
/*::::::::::::::::*/
#include "inc_spellfuncs"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    DoGrease(GetSpellTargetLocation());
}

