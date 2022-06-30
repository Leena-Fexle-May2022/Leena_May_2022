public with sharing class ConvertSobject {
    List<Contact> contacts = new List<Contact>();
    List<Lead> leads = new List<Lead>();
    List<Account> accounts = new List<Account>();
 
    public void convertType(String phoneNumber) {
        List<List<SObject>> results = [FIND :phoneNumber IN Phone FIELDS RETURNING 
                                       Contact(Id, Phone, FirstName, LastName), 
                                       Lead(Id, Phone, FirstName, LastName), 
                                       Account(Id, Phone, Name)];
        List<SObject> records = new List<SObject>();
        records.addAll(results[0]); //add Contact results to our results super-set
        records.addAll(results[1]); //add Lead results
        records.addAll(results[2]); //add Account results
 
        if (!records.isEmpty()) { 
            for (SObject record : records) {   
                if (record instanceof Contact) { 
                    contacts.add((Contact) record);
                    System.debug('instance of contact object : '+record);
                    System.debug('record id of contact object : '+record.id); //sobject acess id
                    System.debug('record name of sobject : '+record.get('FirstName'));
                    System.debug('record name of contact object : '+contacts[0].FirstName); // for first name feild type casting required
                } 
                else if (record.getSObjectType() == Lead.sObjectType){ 
                    leads.add((Lead) record);
                    System.debug('instance of lead object : '+record);
                } 
                else if (record.getSObjectType() == Account.sObjectType) { 
                    accounts.add((Account) record); 
                    System.debug('instance of  object : '+record);
                }
            }
        }
    }
}