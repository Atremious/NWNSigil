#include "inc_text"
void main()
{
    object oPC     = OBJECT_SELF;
    object oTarget = GetLocalObject(oPC, "TELL_TARGET");

    SetLocalObject(oTarget, "InvitedBy", oPC);

    SendMessageToPC(oPC, "You've invited " + GetName(oTarget) + " to your party.");

    SendMessageToPC(oTarget, "You've been invited by " + GetName(oPC) + " to join their party." +
    " Use the chat command" + CLR_Green + "-accept" + CLR_Clear + " to accept their invite.");
}
