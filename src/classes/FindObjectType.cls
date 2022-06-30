public with sharing class FindObjectType {
    public FindObjectType() {
        sObject object1 = new Account();
        object1 =[Select Name from Account limit 1];
        checkInstance(object1);

        /*Account is type casted in contact with no compile time error but contact can't be type casted in account in compile time
        but both will give error on runtime
        Contact c = (Contact) s;
        */
        sObject object2 =[select Name from Contact limit 1];
        checkInstance(object2);
    }
    public void checkInstance(sObject obj){
        if(obj instanceof Account){
            Account account = (Account) obj;
            System.debug('instance of Account type '+ obj);
        }
        else {
            if(obj instanceof Contact){
                Contact contact = (Contact) obj;
                System.debug('instance of Contact type '+ obj);
            } 
        }
    }
}