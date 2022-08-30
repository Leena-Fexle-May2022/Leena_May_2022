public class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select LeadSource, Id from Lead');
    }
    public void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead leads : scope){
            leads.LeadSource='Dreamforce';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        
    }
}