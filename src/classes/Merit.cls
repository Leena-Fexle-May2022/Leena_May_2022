public with sharing class Merit {
    public final static Integer percentCheck = 90;
    public static List <Student__c> s1= new List <Student__c>();
    public static void display() {
        s1 = [select Name, X1st_Sem_Percentage__c from Student__c]; 
        for(Student__c s : Merit.s1)
        {
            if(s.X1st_Sem_Percentage__c > Merit.percentCheck)
                    System.debug(s.Name);
        }

    }
}