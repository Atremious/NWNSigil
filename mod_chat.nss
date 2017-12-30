//#include "nwnx_chat"
#include "inc_gen"
#include "inc_nbde"

//To determine the authority required for a chat command, and the script for it to execute..
//Modify the appropriate setting Waypoints' variables. See their comments/description.
string GetChatScript(string sMsg);
string GetChatScript(string sMsg)
{
    object oData = GetObjectByTag("DATA_CHAT_CMD");

    return GetLocalString(oData, GetStringLowerCase(sMsg));
}

//Returns true of oTarget has oSender tell blocked.
int IsTellBlocked(object oSender, object oTarget);
int IsTellBlocked(object oSender, object oTarget)
{
    return FALSE; //TODO: FIX!!!
}


void main()
{
    object oPC = GetPCChatSpeaker();

    string sMsg    = GetPCChatMessage();
    string sAlertO = "<cá!6>";
    string sAlertC = "</c>";

    SetLocalString(oPC, "LAST_SAID", sMsg);

    /*NWNX Object Variables
    object oSender = NWNX_Chat_GetSender();
    object oTarget = NWNX_Chat_GetTarget();

    //Skip the message if oTarget has oSender tell-blocked, or if they've disabled tells entirely.
    if(NWNX_Chat_GetChannel() == NWNX_CHAT_CHANNEL_PLAYER_TELL)
    {
        if(!GetSettingOn(oTarget, "Tells") && !GetIsDM(oSender))
        {
            NWNX_Chat_SkipMessage();
        }

        if(IsTellBlocked(oSender, oTarget))
        {
            NWNX_Chat_SkipMessage();
        }

        //TODO: Have tells play a sound for ONLY oTarget if they have the setting configured.

    }

    //NWNX Specific Chat Commands

    if(GetStringLowerCase(sMsg) == "-invite" && NWNX_Chat_GetChannel() == NWNX_CHAT_CHANNEL_PLAYER_TELL)
    {

        if(GetIsObjectValid(oTarget))
        {
            SendMessageToPC(oTarget, sAlertO + GetName(oSender) + " has invited you to their party." +
            " To accept, use the chat command -accept." + sAlertC);

        //TODO: Have -invite play a sound for ONLY oTarget if they have the setting configured.

            SetTimedLocalObject(oTarget, "InvitedBy", oSender, 30.0);
            SetCooldown(oSender, "-invite", 5.0);
        }

        if(!GetIsObjectValid(oTarget))
        {
            SendMessageToPC(oSender, sAlertO + "To use this command, send the chat command -invite as a tell " +
            "to another player." + sAlertC);
        }

        if(GetIsOnCooldown(oSender, "-invite"))
        {
            SendMessageToPC(oSender,"You cannot use this command yet.");
        }
    }

    if(GetStringLowerCase(sMsg) == "-accept" && GetIsObjectValid(GetLocalObject(oSender, "InvitedBy")))
    {
        AddToParty(oSender, GetLocalObject(oSender, "InvitedBy"));

    }*/

    if(sMsg == "-test")
    {
        SendMessageToPC(oPC, "key is " + NBDE_GetCampaignString("PLAYERNAME_DATA", GetPCPlayerName(oPC) + "_KEY"));
    }

    if(sMsg == "-flush")
    {
        DelayCommand(1.0, NBDE_FlushCampaignDatabase("PC_DATA"));
        DelayCommand(3.0, NBDE_FlushCampaignDatabase("PLAYERNAME_DATA"));
        SendMessageToPC(oPC, "Flushed");
    }


    //Normal Chat Commands
    if(GetSubString(sMsg, 0, 1) == "-")
    {
        ExecuteScript(GetChatScript(sMsg), oPC);
        SetPCChatMessage("");
    }

    if(GetPCChatVolume() == TALKVOLUME_SHOUT && !GetIsDM(oPC))
    {
        SendMessageToPC(oPC, "Shout is currently disabled.");
        SetPCChatMessage("");
    }
}
