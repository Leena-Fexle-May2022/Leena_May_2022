public with sharing class PrimitiveDataType {
    public PrimitiveDataType() {
        Boolean isWinner = true;
        System.debug('boolean '+ isWinner);

        Double doublevalue=3.14159;
        System.debug('double ' + doublevalue);

        ID id='00300000003T2PGAA0';
        System.debug('id '+ id);

        Integer num= 1;
        System.debug('integer ' +num);

        Long longvalue = 2147483648L;
        System.debug('long ' + longvalue);

        Object obj = 10;
        System.debug('object'+obj);
        // Cast the object to an integer.
        Integer conversion = (Integer)obj;
        System.assertEquals(10, conversion);

        Date myDate = Date.newInstance(1960, 2, 17);
        System.debug('date '+myDate);
        Date newDate = mydate.addDays(2);
        System.debug('add 2 days '+newDate);
        date newDate2 = myDate.addMonths(3);
        System.debug('add 3 months '+newDate2);
        date newDate3 = myDate.addYears(2);
        System.debug('add 2 years '+newDate3);
        
        Datetime myDateTime = Datetime.newInstance(1960, 2, 17);
        System.debug('Date time '+myDatetime);
        DateTime newDateTime = myDateTime.addMinutes(7);
        System.debug('add 7 minutes '+newDatetime);
        DateTime newDateTime2 = myDateTime.addHours(7);
        System.debug('add 7 hours '+newDatetime2);
        DateTime newDateTime3 = myDateTime.addSeconds(7);
        System.debug('add 7 secondss '+newDatetime3);

        String myString = 'hello maximillian';
        System.debug('String'+ myString);
        String myString2 = myString.capitalize();
        System.debug('Capitalize String'+ myString2);
        System.debug(myString.charAt(3));
        System.debug(myString.containsAny('ize'));     
    }
}