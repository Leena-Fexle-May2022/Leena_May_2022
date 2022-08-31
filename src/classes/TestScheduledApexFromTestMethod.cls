global class TestScheduledApexFromTestMethod implements Schedulable {
    public static String CRON_EXP = '0 0 0 22 8 ? 2022';
    global void execute(SchedulableContext ctx) {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        System.assertEquals('2022-08-22 00:00:00', String.valueOf(ct.NextFireTime));
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'testScheduledApexFromTestMethod'];
        acc.name = 'testScheduledApexFromTestMethodUpdated';
        update acc;
    }   
}