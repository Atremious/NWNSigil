void main()
{
        object oCache = CreateObject(OBJECT_TYPE_PLACEABLE, "PLC_MOBLOOT", GetLocation(OBJECT_SELF));
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectVisualEffect(501)), oCache);

        SetLocalString(oCache, "LOOT_CONTAINER_TAG", GetLocalString(OBJECT_SELF, "LOOT_CONTAINER_TAG"));
        SetLocalInt(oCache, "LOOT_GP_BASE", GetLocalInt(OBJECT_SELF, "LOOT_GP_BASE"));
        SetLocalInt(oCache, "LOOT_GP_RANDOM", GetLocalInt(OBJECT_SELF, "LOOT_GP_RANDOM"));

        DelayCommand(120.0, DestroyObject(oCache));
}
