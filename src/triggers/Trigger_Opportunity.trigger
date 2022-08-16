trigger Trigger_Opportunity on Opportunity (after insert, after update) {
    if(Trigger.isInsert && Trigger.isAfter){
        OpportunityTriggerHelper.insertOpportunity(Trigger.New);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHelper.insertOpportunity(Trigger.New);
        OpportunityTriggerHelper.deleteRecords(Trigger.New,Trigger.OldMap);
        OpportunityTriggerHelper.updateOpportunity(Trigger.New,Trigger.OldMap);
        OpportunityTriggerHelper.sendEmail2(Trigger.New,Trigger.OldMap);
    }
}