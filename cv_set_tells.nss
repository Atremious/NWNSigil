#include "inc_gen"
void main()
{
    object oPC;

    if(GetPCSpeaker() == OBJECT_INVALID)
    {
        oPC = OBJECT_SELF;
    }

    else
    {
        oPC = GetPCSpeaker();;
    }

    ToggleSetting(oPC, "Tells");
}
