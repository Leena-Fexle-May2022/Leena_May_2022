trigger Trigger_District on District__c (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        DistrictTriggerHelper.updateStateRecord(Trigger.New, Trigger.OldMap);
    }
}