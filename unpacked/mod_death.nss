#include "x3_inc_horse"
#include "inc_gen"
void Raise(object oPlayer)
{
        effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);

        effect eBad = GetFirstEffect(oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);

        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    //Remove effect if it is negative.
                    RemoveEffect(oPlayer, eBad);
                }
            eBad = GetNextEffect(oPlayer);
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}


///////////////////////////////////////////////////////////////[ MAIN ]/////////
void main()
{
    object oPC     = GetLastPlayerDied();
    object oKiller = GetLastKiller();

    string sArea = GetName(GetArea(oPC));
    string sPvP;
    string sExtra;

    DelayCommand(2.5, PopUpGUIPanel(oPC,GUI_PANEL_PLAYER_DEATH));

    if(GetIsPC(oKiller))
    {
        sPvP   = "PVP";
        sExtra = " (" + GetPCPublicCDKey(oKiller) + ")";
    }

    if(!GetIsPC(oKiller))
    {
        sPvP   = "PVE";
        sExtra = "";
    }

    LogMessage("[DEATH]: " + GetName(oPC) + " (" + GetPCPublicCDKey(oPC) + ") [" + sArea + "] (" + sPvP + "): Killed by " + GetName(oKiller) + sExtra + ".");


}
///////////////////////////////////////////////////////////////[ MAIN ]/////////

