#include "inc_nbde"
void main()
{
    int nCount = GetLocalInt(OBJECT_SELF, "HB_COUNT");
    SetLocalInt(OBJECT_SELF, "HB_COUNT", nCount + 1);

    //Flush databases every 5 minutes.
    if(GetLocalInt(OBJECT_SELF, "HB_COUNT") == 50)
    {
        DelayCommand(1.0, NBDE_FlushCampaignDatabase("PC_DATA"));

        SetLocalInt(OBJECT_SELF, "HB_COUNT", 0);
    }


}
