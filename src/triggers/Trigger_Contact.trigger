trigger Trigger_Contact on Contact (before insert) {
    ContactTriggerHandler.insertStatus(Trigger.New);
}