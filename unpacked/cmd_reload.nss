void main()
{
    object oPC = OBJECT_SELF;

    //If get is admin
    SendMessageToPC(oPC, "cmd_reload called");
    StartNewModule(GetName(GetModule()));
}
