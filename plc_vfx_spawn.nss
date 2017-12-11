#include "nw_i0_plot"
#include "nw_i0_spells"
#include "x2_inc_toollib"
void main()
{
    if (GetLocalInt(OBJECT_SELF, "AR_DO_ONCE"))
        return;

    SetLocalInt(OBJECT_SELF, "AR_DO_ONCE", TRUE);

    object oObject = GetFirstObjectInArea();
    while (GetIsObjectValid(oObject))
    {
        int iEffect  = GetLocalInt(oObject, "VFX");
        int iEffect1 = GetLocalInt(oObject, "VFX_1");
        int iEffect2 = GetLocalInt(oObject, "VFX_2");

        if (iEffect) {
            effect eEffect = EffectVisualEffect(iEffect);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oObject);
        }

        if (iEffect1) {
            effect eEffect = EffectVisualEffect(iEffect1);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oObject);
        }

        if (iEffect2) {
            effect eEffect = EffectVisualEffect(iEffect2);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oObject);
        }
        oObject = GetNextObjectInArea();
    }

    DestroyObject(OBJECT_SELF, 1.0);
}

