public class addStudent {
    public static void addStudentRecord(){
        // Insert Student Record
      
        Student__c s1 = new Student__c();
        
        // Personal Information
        s1.Name = 'Aditya Sharma';
        s1.Email__c = 'adityasharma@gmail.com';
        s1.Father_Name__c = 'Om Sharma';
        s1.Address__c = '276, Mirzapur, Uttar Pradesh';
        s1.Mobile_Number__c = '980584728';
        s1.Father_Mobile_Number__c = '98896956';
        s1.Home_Phone__c = '0141203024';

        // Class Information   
        s1.Stream__c = 'Commerce';
        s1.Class__c = 'MBA';
        s1.Section__c = 'C';
        
        // Semester Information
        s1.X1st_Sem_Percentage__c = 85;
        s1.X1st_Sem_Back__c = false;
        s1.X2nd_Sem_Percentage__c = 65;
        s1.X2nd_Sem_Back__c = false;
        s1.X3rd_Sem_Percentage__c = 72;
        s1.X3rd_Sem_Back__c = false;
        s1.X4th_Sem_Percentage__c = 35;
        s1.X4th_Sem_Back__c = true;
        s1.Subjects_In_Which_Back_4thSem__c = 'Accounts; Mathematics';
        
        // Fees Information
        s1.Current_Year__c = 2021;
        s1.Fees_Submitted__c = true;
        s1.Pending_Fees_Amount__c = 0;
        s1.Exam_Fess_Submitted__c = false;
        s1.Pending_Exam_Fees__c = 550;
        
        // Bank Information
        s1.Bank_Name__c = 'Kotak Mahindra Bank';
        s1.IFSC_Code__c = 'KM023695';
        s1.Account_Number__c = 54678990890l;
        s1.City__c = 'Mirzapur';
        s1.State__c = 'Uttar Pradesh';
        s1.Bank_Phone_Number__c = '9802309867';
        
        // Other Information
        s1.Linkedin_Url__c = 'https://linkedin.com/';
        s1.Credit_Card_Number__c = '98764567891223';
        s1.Time__c = Time.newInstance(4, 24, 0, 0);
        s1.Date_And_Time__c = DateTime.newInstance(2021, 01, 23, 13, 20, 0);
        s1.Date_Of_Birth__c = Date.newInstance(2000, 01, 25);
        
        // Insert Command
        insert s1;
        system.debug(s1.id);
    }
}