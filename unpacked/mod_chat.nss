#include "nwnx_chat"
#include "inc_gen"
#include "inc_text"

string GetChatScript(string sMsg);
string GetChatScript(string sMsg)
{
    object oData = GetObjectByTag("DATA_CHAT_CMD");

    return GetLocalString(oData, GetStringLowerCase(sMsg));
}

void ExamineChatCommand(object oPC, string sCommand);
void ExamineChatCommand(object oPC, string sCommand)
{
    sCommand = GetStringUpperCase(sCommand);
    sCommand = GetSubString(sCommand, 1, GetStringLength(sCommand));
    sCommand = GetSubString(sCommand, 0, GetStringLength(sCommand) - 1);

    string sVar = GetLocalString(GetObjectByTag("DATA_CHAT_DESC"), GetStringLowerCase(sCommand));

    object Examine = GetObjectByTag(sVar);
    SetLocalObject(oPC, "EXAMINE", Examine);

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionExamine(GetLocalObject(oPC, "EXAMINE")));
}

//Returns true of oTarget has oSender tell blocked.
int IsTellBlocked(object oSender, object oTarget);
int IsTellBlocked(object oSender, object oTarget)
{
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget);

    if(GetLocalInt(oHide, "TL_" + GetPCPlayerName(oSender)))
    {
        return TRUE;
    }

    return FALSE;
}

string GetVolumePrefix(int NWNX)
{
    string sVol;

    if(NWNX == 0)
    {
        switch(GetPCChatVolume())
        {
            case TALKVOLUME_TALK:

                sVol = "T";

            break;

            case TALKVOLUME_WHISPER:

                sVol = "W";

            break;

            case TALKVOLUME_PARTY:

                sVol = "P";

            break;

            case TALKVOLUME_SHOUT:

                sVol = "S";

            break;

            case TALKVOLUME_SILENT_TALK:

                sVol = "DM";

            break;
        }
    }

    if(NWNX == 1)
    {
        switch(NWNX_Chat_GetChannel())
        {
            case NWNX_CHAT_CHANNEL_DM_DM:

                sVol = "DM";

            break;

            case NWNX_CHAT_CHANNEL_PLAYER_DM:

                sVol = "DM";

            break;

            case NWNX_CHAT_CHANNEL_DM_PARTY:

                sVol = "P";

            break;

            case NWNX_CHAT_CHANNEL_PLAYER_PARTY:

                sVol = "P";

            break;

            case NWNX_CHAT_CHANNEL_DM_SHOUT:

                sVol = "S";

            break;

            case NWNX_CHAT_CHANNEL_PLAYER_SHOUT:

                sVol = "S";

            break;

            case NWNX_CHAT_CHANNEL_DM_TALK:

                sVol = "T";

            break;

            case NWNX_CHAT_CHANNEL_PLAYER_TALK:

                sVol = "T";

            break;

            case NWNX_CHAT_CHANNEL_DM_TELL:

                sVol = "TL";

            break;

            case NWNX_CHAT_CHANNEL_PLAYER_TELL:

                sVol = "TL";

            break;


            case NWNX_CHAT_CHANNEL_DM_WHISPER:

                sVol = "W";

            break;

            case NWNX_CHAT_CHANNEL_PLAYER_WHISPER:

                sVol = "W";

            break;
        }
    }

    return sVol;
}


void main()
{
    int NWNX;
    int nChannel = NWNX_Chat_GetChannel();

    object oPC      = GetPCChatSpeaker();
    object oTarget  = NWNX_Chat_GetTarget();

    string sMessage = NWNX_Chat_GetMessage();

    string sArea    = GetName(GetArea(oPC));
    string sVolume;

    if(GetStringLength(sMessage) < 1)
    {
        NWNX = 0;
        nChannel = GetPCChatVolume();
        sMessage = GetPCChatMessage();
    }

    sVolume  = GetVolumePrefix(NWNX);

    SetLocalString(oPC, "LAST_SAID", sMessage);

    if(GetSubString(sMessage, GetStringLength(sMessage) - 1, GetStringLength(sMessage)) == "?" && GetSubString(sMessage, 0, 1) == "-")
    {
        SetPCChatMessage("");
        ExamineChatCommand(oPC, sMessage);
        return;
    }

    if(sVolume == "TL")//Tells
    {
        if(IsTellBlocked(oPC, oTarget) && !GetIsDM(oPC) || GetSettingOn(oTarget, "Disable Tells") && !GetIsDM(oPC))
        {
            NWNX_Chat_SkipMessage();
            return;
        }

        if(GetSubString(sMessage, 0, 1) == "-")
        {
            NWNX_Chat_SkipMessage();
            SetLocalObject(oPC, "TELL_TARGET", oPC);
            ExecuteScript(GetChatScript(sMessage), oPC);
        }
    }

    if(sVolume != "TL")//Not Tells: DM, Talk, Party, Shout, Whisper
    {
        if(GetSubString(sMessage, 0, 1) == "-")
        {
            SetPCChatMessage("");
            ExecuteScript(GetChatScript(sMessage), oPC);

            SendMessageToPC(oPC, "Running " + GetChatScript(sMessage));
        }

        if(nChannel == NWNX_CHAT_CHANNEL_DM_SHOUT && !GetIsDM(oPC) || nChannel == TALKVOLUME_SHOUT && !GetIsDM(oPC))
        {
            SetPCChatMessage("");
            PCShoutMessage(oPC, sMessage);
        }
    }
}
