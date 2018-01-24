//::///////////////////////////////////////////////
//:: Name: x2_onrest
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The generic wandering monster system
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: June 9/03
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified Date: January 28th, 2008
//:://////////////////////////////////////////////

#include "x2_inc_restsys"
#include "x2_inc_switches"
#include "x3_inc_horse"

void main()
{
    object oPC = GetLastPCRested();
    int nNap = GetLocalInt(oPC, "NAP");

    if (nNap == 0)
    {
        if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
        {
        AssignCommand(oPC, ClearAllActions(1));
        AssignCommand(oPC, ActionStartConversation(oPC, "cv_menu_rest", 1, 0));
        }
    }

    SetLocalInt(oPC, "NAP", 0);
}
