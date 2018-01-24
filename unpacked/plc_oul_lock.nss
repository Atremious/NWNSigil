void main()
{
    object oPC = GetLastUnlocked();
    float fDur = GetLocalFloat(OBJECT_SELF, "COOLDOWN_DUR");

    DelayCommand(fDur, SetLocked(OBJECT_SELF, TRUE));
}
