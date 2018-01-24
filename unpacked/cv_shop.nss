void main()
{
    object oShop = GetNearestObjectByTag("SHOP");
    object oPC   = GetPCSpeaker();

    OpenStore(oShop, oPC);
}
