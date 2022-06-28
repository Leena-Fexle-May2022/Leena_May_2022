public with sharing class OperatorsAndExpressions {
    public OperatorsAndExpressions() 
    {
        integer value1=5;
        integer value2=7;
        //arthematic operator
        System.debug('Sum= '+(value1 + value2));
        System.debug('Diffrence= '+(value2 - value1));
        System.debug('Multiply= '+(value1 * value2));
        System.debug('Division= '+(value2 / value1));
        
        //short hand operators
        value1 += value2;
        System.debug('addition and assignment in value1= '+ value1 );
        value1 -= value2;
        System.debug('substration and asignment in value1= '+ value1 );
        value1 *= value2;
        System.debug('multiplication and asignment in value1= '+ value1 );
        value1 /= value2;
        System.debug('Division and asignment in value1= '+value1 );

        //logical and ternary operator
        String message= value1>value2? 'value 1 is greater': 'value 2 is greater';
        System.debug(message);
        message= ((value1>10) && (value2>50 )) || ((value2>10) && (value1>50 ))?'true': 'false';
        System.debug(message);

        //safe navigation operator
        message=[select Name from Student__c limit 1]?.Name;
        System.debug('Student name: '+message);

        //explicit type conversion
        Decimal value3 = 45.115;
        Integer value4 = (Integer) value3;
        System.debug('The decimal is: '+ value3 + '. The integer is: ' + value4);

        //implicit type conversion
        double conversion=value2/value1;
        System.debug('implicit conversion: '+conversion);
    }
}