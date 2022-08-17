trigger Trigger_Contact on Contact (before insert, after update) {
    if(Trigger.isInsert && Trigger.isBefore){
        ContactTriggerHandler.insertStatus(Trigger.New);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        ContactTriggerHandler.contactStatusSync(Trigger.New, Trigger.OldMap);
    }
}