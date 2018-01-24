#include "inc_text"
//Includes general scripting commands.

/*////////////////////////////////////////////|
Sets a timed local object on oObject.
oObject - the object to set the local object on. sVarname - the variable name of the local object.
oValue - the local object to set on oObject. fTimeToExpire - how long the local object will last.
*/////////////////////////////////////////////|

void SetTimedLocalObject(object oObject, string sVarName, object oValue, float fTimeToExpire);
void SetTimedLocalObject(object oObject, string sVarName, object oValue, float fTimeToExpire)
{
        SetLocalObject(oObject, sVarName, oValue);
        DelayCommand(fTimeToExpire, SetLocalObject(oObject, sVarName, OBJECT_INVALID));
}

void SetCooldown(object oPC, string sCooldownName, float fCooldownDuration);
void SetCooldown(object oPC, string sCooldownName, float fCooldownDuration)
{
        SetLocalString(oPC, "CD_" + sCooldownName, "ON_CD");
        DelayCommand(fCooldownDuration, SetLocalString(oPC, "CD_" + sCooldownName, ""));
}

int GetIsOnCooldown(object oPC, string sCooldownName);
int GetIsOnCooldown(object oPC, string sCooldownName)
{
        if(GetLocalString(oPC, "CD_" + sCooldownName) == "")
        {
            return TRUE;
        }

        else
        {
            return FALSE;
        }
}

void ToggleSetting(object oPC, string sSetting);
void ToggleSetting(object oPC, string sSetting)
{
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

        if(GetLocalString(oHide, "SET_" + sSetting) != "ON")
        {
            SetLocalString(oHide, "SET_" + sSetting, "ON");
            SendMessageToPC(oPC, "Setting " + sSetting + " is now enabled.");
        }

        if(GetLocalString(oHide, "SET_" + sSetting) == "ON")
        {
            SetLocalString(oHide, "SET_" + sSetting, "OFF");
            SendMessageToPC(oPC, "Setting " + sSetting + " is now disabled.");
        }
}

int GetSettingOn(object oPC, string sSetting);
int GetSettingOn(object oPC, string sSetting)
{
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

        if(GetLocalString(oHide, "SET_" + sSetting) == "ON")
        {
            return TRUE;
        }

        else
        {
            return FALSE;
        }
}

void RecreateObject(object oRecreate);
void RecreateObject(object oRecreate)
{
    location lRec = GetLocation(oRecreate);

    if(GetLocalString(oRecreate, "RECREATE_WP") != "")
    {
       lRec = GetLocation(GetObjectByTag(GetLocalString(oRecreate, "RECREATE_WP")));
    }

    object oNew = CreateObject(OBJECT_TYPE_CREATURE, GetResRef(oRecreate), lRec);
}


