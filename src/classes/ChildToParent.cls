public with sharing class ChildToParent {
    public void AccountOpportunity(Integer size)
    {
        List <Opportunity> opportunityList = new List <Opportunity>();
        Account account = [select id from Account where Name='Acme1' limit 1];
        for(Integer num=1 ; num<=size; num++){
            opportunityList.add(new Opportunity(Name='oppurtunity'+num, AccountId=account.Id, StageName='Prospecting', CloseDate=Date.Today()+10));
        }
        insert opportunityList;
        Account account2 = [select id from Account where Name='Acme2' limit 1];
        for(Opportunity opp:opportunityList){
            opp.AccountId=account2.Id;
        }
        update opportunityList;
        for( Opportunity oppl :[select Name, Account.Name from Opportunity where Name like 'oppurtunity%'] ) {
            System.debug('Opportunity : '+oppl.Name+', Account :'+oppl.Account.Name);
        }
        delete opportunityList;
    }
    public void TeacherCollege(){
        for(Teacher__c teacher : [select Name, College__r.Name from Teacher__c]){
            System.debug('Teacher Name :'+teacher.Name+'College Name'+teacher.College__r);
        }
    }
}