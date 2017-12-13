/*::::::::::::::::/*
Fireball: 3rd Circle, Wizard & Sorcerer

    You create a small stroke of lightning that
    cycles through all creatures in the area of effect.
    The spell deals 1d6 points of damage per 2 caster
    levels (maximum 5d6). Those who fail their Reflex
    saves must succeed at a Will save or be stunned
    for 1 round.
/*::::::::::::::::*/

#include "inc_spellfuncs"
void main()
{

    //--------------------------------------------------------------------------
    // Spellcast Hook Code
    // Added 2003-06-20 by Georg
    // If you want to make changes to all spells, check x2_inc_spellhook.nss to
    // find out more
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }

    if (!GetHasStringOnEquippedItems(OBJECT_SELF, "MOD_EXTRA_GEDLEES"))
    {
        DoGedlees(GetSpellTargetLocation());
    }

    //If has an item with the gedlees amount passive increase, do two extra explosions at random locations.
    if (GetHasStringOnEquippedItems(OBJECT_SELF, "MOD_EXTRA_GEDLEES"))
    {
        SpeakString("has MOD_EXTRA_GEDLEES");
        DoGedlees(GetSpellTargetLocation(), VFX_BEAM_LIGHTNING, 15, RADIUS_SIZE_COLOSSAL);
        DelayCommand(0.6, DoGedlees(GetSpellTargetLocation(), VFX_BEAM_LIGHTNING, 12, RADIUS_SIZE_COLOSSAL));
        DelayCommand(1.2, DoGedlees(GetSpellTargetLocation(), VFX_BEAM_LIGHTNING, 10, RADIUS_SIZE_COLOSSAL));

    }

}


