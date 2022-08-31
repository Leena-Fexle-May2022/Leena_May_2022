trigger Trigger_State on State__c (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        StateTriggerHelper.updateCountryRecord(Trigger.New,Trigger.OldMap);
    }
}