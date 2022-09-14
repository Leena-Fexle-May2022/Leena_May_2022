public class FetchingRecords {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContact(Id accId){
        List<Contact> listContact = [Select Id, Name from Contact where AccountId = :accId];
        return listContact;
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(Id accId){
        List<Opportunity> listOpp = [Select Id, Name from Opportunity where AccountId = :accId];
        return listOpp;
    }
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(Id accId){
        List<Case> listCase = [Select Id,CaseNumber from Case where AccountId = :accId];
        return listCase;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id,Name,Phone,Email FROM Contact LIMIT 10];
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(String input) {
        return [SELECT Id,Name FROM Account WHERE Name like :'%'+input+'%'];
    }
}