//Returns true if oPC has the quest of sQuestName completed.
int GetHasQuestCompleted(object oPC, string sQuestName);
int GetHasQuestCompleted(object oPC, string sQuestName)
{
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    if(GetLocalInt(oHide, sQuestName + "_C") == 1)
    {
        return TRUE;
    }

    return FALSE;
}

//Returns true if oPC has the quest of sQuestName in progress.
int GetHasQuestInProgress(object oPC, string sQuestName);
int GetHasQuestInProgress(object oPC, string sQuestName)
{
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    if(GetLocalInt(oHide, sQuestName + "_IP") == 1)
    {
        return TRUE;
    }

    return FALSE;
}

//Returns true if oPC has the quest of sQuestName in progres, or completed.
int GetHasQuest(object oPC, string sQuestName);
int GetHasQuest(object oPC, string sQuestName)
{
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    if(GetLocalInt(oHide, sQuestName + "_IP") || GetLocalInt(oHide, sQuestName + "_C"))
    {
        return TRUE;
    }

    return FALSE;
}

//Gives oPC the quest by sQuestName.
//sQuestName must be a journal entry.
void GiveQuest(object oPC, string sQuestName);
void GiveQuest(object oPC, string sQuestName)
{
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    if(!GetHasQuest(oPC, sQuestName))
    {
        AddJournalQuestEntry(sQuestName + "_IP", 1, oPC, FALSE, FALSE, FALSE);
        SetLocalInt(oHide, sQuestName + "_IP", 1);
    }
}

//Marks the quest of sQuestName complete for oPC.
//sQuestName must be a journal entry.
void CompleteQuest(object oPC, string sQuestName, int nGP = 0, int nXP = 0);
void CompleteQuest(object oPC, string sQuestName, int nGP = 0, int nXP = 0)
{
    object oHide  = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);

    if(nXP == 0)
    {
        nXP = GetJournalQuestExperience(sQuestName + "_C");
    }

    if(nGP == 0)
    {
        nGP = nXP / 5;
    }

    RemoveJournalQuestEntry(sQuestName + "_IP", oPC, FALSE, FALSE);

    DeleteLocalInt(oHide, sQuestName + "_IP");
    SetLocalInt(oHide, sQuestName + "_C", 1);


    if(nXP > 0)
    {
        GiveXPToCreature(oPC, nXP);
    }

    if(nGP > 0)
    {
        GiveGoldToCreature(oPC, nGP);
    }

    SendMessageToPC(oPC, "You have completed a quest.");
    AssignCommand(oPC, PlaySound("gui_quest_done"));
}

void DoJournalUpdate(object oPC);
void DoJournalUpdate(object oPC)
{
    object oWP = GetObjectByTag("QUEST_IDS");
    int nTotal = GetLocalInt(oWP, "QUEST_COUNT");

    int nCount = 0;
    string sUpdate;

    while(nCount < nTotal)
    {
        sUpdate = GetLocalString(oWP, "ID_" + IntToString(nCount));
        SendMessageToPC(oPC, "Testing if has " + sUpdate);

        if(GetHasQuestInProgress(oPC, sUpdate))
        {
            AddJournalQuestEntry(sUpdate + "_IP", 1, oPC, FALSE, FALSE, FALSE);
        }

        nCount++;
    }
}
