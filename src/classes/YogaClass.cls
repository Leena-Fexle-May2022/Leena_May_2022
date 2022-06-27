public with sharing class YogaClass {
    public YogaClass() {
        //declaring yoga class map
        Map< String, Map< String, List<Student__c>>> yogaClassMap = new Map< String, Map< String, List<Student__c>>>();

        //list of first year science
        List < Student__c > firstYearListScience = new List < Student__c >();
        firstYearListScience = [ Select Id, Roll_Number__c, Name, Year_of_Class__r.Name, Stream__c FROM Student__c
			                     WHERE Year_of_Class__r.Name ='First Year' and Stream__c = 'Science' ];

        Map< String, List< Student__c > > studentFirstYearMap = new Map< String, List< Student__c>>();
        studentFirstYearMap.put( 'Science' , firstYearListScience );

        //list of Second year commerce
        List < Student__c > secondYearListCommerce = new List < Student__c >();
        secondYearListCommerce = [ Select Id, Roll_Number__c, Name, Year_of_Class__r.Name, Stream__c FROM Student__c
			                        WHERE Year_of_Class__r.Name ='Second Year' and Stream__c = 'Commerce' ];

        Map< String, List< Student__c > > studentSecondYearMap = new Map< String, List< Student__c>>();
        studentSecondYearMap.put( 'Commerce' , secondYearListCommerce );

        //list of third year arts
        List < Student__c > thirdYearListArts = new List < Student__c >();
        thirdYearListArts = [ Select Id, Roll_Number__c, Name, Year_of_Class__r.Name, Stream__c FROM Student__c
			                  WHERE Year_of_Class__r.Name ='Third Year' and Stream__c = 'Arts' ];

        Map< String, List< Student__c > > studentThirdYearMap = new Map< String, List< Student__c>>();
        studentThirdYearMap.put( 'Arts' , thirdYearListArts );

        //intialising yoga map
        yogaClassMap.put('First Year', studentFirstYearMap);
        yogaClassMap.put('Second Year', studentSecondYearMap);
        yogaClassMap.put('Third Year',studentThirdYearMap);

        //displaying map values
        System.debug('First year Students: '+yogaClassMap.get('First Year'));
        System.debug('Second year Students: '+yogaClassMap.get('Second Year'));
        System.debug('Third year Students: ' +yogaClassMap.get('Third Year'));
    }
}