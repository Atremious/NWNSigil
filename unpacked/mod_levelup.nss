#include "inc_gen"
#include "nwnx_creature"

void main()
{
    object oPC = GetPCLevellingUp();
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    string sArea = GetName(GetArea(oPC));

    LogMessage("[LVLUP]: " + GetName(oPC) + " (" + GetPCPublicCDKey(oPC) + ") [" + sArea + "] Level Up: Now " + IntToString(GetHitDice(oPC)) + ".");

    //Rangers & Paladins get +1 Wisdom at level 9 and 18.
    if(GetLevelByClass(CLASS_TYPE_PALADIN) >= 9 && !GetLocalInt(oHide, "PAL_WIS_9"))
    {
        SetLocalInt(oHide, "PAL_WIS_9", 1);
        NWNX_Creature_SetAbilityScore(oPC, ABILITY_WISDOM, GetAbilityScore(oPC, ABILITY_WISDOM, TRUE) + 1);
    }

    if(GetLevelByClass(CLASS_TYPE_PALADIN) >= 18 && !GetLocalInt(oHide, "PAL_WIS_18"))
    {
        SetLocalInt(oHide, "PAL_WIS_18", 1);
        NWNX_Creature_SetAbilityScore(oPC, ABILITY_WISDOM, GetAbilityScore(oPC, ABILITY_WISDOM, TRUE) + 1);
    }

    if(GetLevelByClass(CLASS_TYPE_RANGER) >= 9 && !GetLocalInt(oHide, "RAN_WIS_9"))
    {
        SetLocalInt(oHide, "PAL_WIS_9", 1);
        NWNX_Creature_SetAbilityScore(oPC, ABILITY_WISDOM, GetAbilityScore(oPC, ABILITY_WISDOM, TRUE) + 1);
    }

    if(GetLevelByClass(CLASS_TYPE_RANGER) >= 18 && !GetLocalInt(oHide, "RAN_WIS_18"))
    {
        SetLocalInt(oHide, "PAL_WIS_18", 1);
        NWNX_Creature_SetAbilityScore(oPC, ABILITY_WISDOM, GetAbilityScore(oPC, ABILITY_WISDOM, TRUE) + 1);
    }
}
