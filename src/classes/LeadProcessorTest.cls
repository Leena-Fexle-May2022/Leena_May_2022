@isTest
public class LeadProcessorTest {
	@testSetup
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        // insert 200 accounts
        for (Integer i=0;i<200;i++) {
            leadList.add(new Lead (LastName ='Test Lead', Company='Test Company'));
        }
        insert leadList;
    }
     @isTest static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}