//:: LIBRARY OF COLOR STRINGS ::\\

const string CLR_Green       = "<cþ>";
const string CLR_Grey        = "<c€€€>";
const string CLR_Purple      = "<c•7È>";
const string CLR_LightOrange = "<cþ£F>";
const string CLR_Orange      = "<cþ€>";
const string CLR_Red         = "<cþ>";
const string CLR_White       = "<cýþþ>";

const string CLR_Clear = "</c>";

const string CLR_GP = "<cþþ>";
const string CLR_XP = "<c£Âó>";

string CapitalizeFirst(string sString);
string CapitalizeFirst(string sString)
{

string sLC = GetStringLowerCase(sString);
string sFirst = GetSubString(sLC, 0, 1);
string sRemaining = GetSubString(sLC, 1, GetStringLength(sLC));

string sReturn = GetStringUpperCase(sFirst) + sRemaining;

return sReturn;

}

void LogMessage(string sMessage);
void LogMessage(string sMessage)
{
    WriteTimestampedLogEntry(sMessage);
}

void PCShoutMessage(object oPC, string sMessage);
void PCShoutMessage(object oPC, string sMessage)
{
        if(GetSubString(sMessage, 0, 1) != "-")
        {
            AssignCommand(oPC, SpeakString(sMessage, TALKVOLUME_TALK));
        }

        object oPlayer = GetFirstPC();
        while(GetIsObjectValid(oPlayer))
        {
            if(GetArea(oPlayer) == GetArea(oPC))
            {
                SendMessageToPC(oPlayer, GetName(oPC) + " [Shout]: " + CLR_White + sMessage + CLR_Clear);
            }

            oPlayer = GetNextPC();
        }
}


