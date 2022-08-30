trigger Trigger_Property on Property__c (after update) {
    PropertyTriggerHelper.propertyStatusSync(Trigger.New, Trigger.OldMap);
}