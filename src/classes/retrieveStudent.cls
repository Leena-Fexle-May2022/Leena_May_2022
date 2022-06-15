public class retrieveStudent {
    public static void retrieveStudentRecord()
    {
	List<Student__c> studentList = [Select Name, Email__c, Stream__c, Class__c, Section__c, Father_Name__c, Address__c, Father_Mobile_Number__c,
                                        Home_Phone__c, X1st_Sem_Percentage__c, X1st_Sem_Back__c, X2nd_Sem_Percentage__c, X2nd_Sem_Back__c,
                                        X3rd_Sem_Percentage__c,X3rd_Sem_Back__c,X4th_Sem_Percentage__c, X4th_Sem_Back__c, 
                                        Subjects_In_Which_Back_4thSem__c, Current_Year__c,Fees_Submitted__c, Pending_Fees_Amount__c,
                                        Exam_Fess_Submitted__c,Pending_Exam_Fees__c, Bank_Name__c,IFSC_Code__c, Account_Number__c, City__c,
                                        State__c, Bank_Phone_Number__c, Linkedin_Url__c, Credit_Card_Number__c, Date_And_Time__c, Date_Of_Birth__c 
                                        from Student__c limit 5];

	for(Student__c student : studentList)
	{
		system.debug('Student Data : ' + student);
	}  
    }

}
