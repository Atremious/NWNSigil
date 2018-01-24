//When this script is called, the NPC from the conversation will cast a 'fake' spell.
//Only the animation and visuals will play, the actual spell won't.
void main()
{
    object oPC  = GetPCSpeaker();
    object Self = OBJECT_SELF;

    int nSpell = SPELL_MAGIC_MISSILE;

    if(GetLocalInt(OBJECT_SELF, "CV_CAST"))
    {
        nSpell = GetLocalInt(OBJECT_SELF, "CV_CAST");
    }

    ActionCastFakeSpellAtObject(nSpell, oPC);
}
