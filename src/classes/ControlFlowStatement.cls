public with sharing class ControlFlowStatement {
    //if else use determining sign of number
    public static void integerSign(Integer value) {
        Integer sign;
        if (value <= 0) {
            sign = 0;   
        }
        else  {
           sign = -1;
        }
        System.debug('number= '+value+'sign= '+sign);
    }
    
    //if else ladder use determining color of med according to posiion
    public static void medalColor(Integer place) 
    {
        String medal_color;
        if (place == 1) 
        {
            medal_color = 'gold';
        } 
        else if (place == 2) 
        {
            medal_color = 'silver';
        } 
        else if (place == 3)
        {
            medal_color = 'bronze';
        } else {
            medal_color = null;
        }
        System.debug('medal color is: '+medal_color);
    }

    //use of do while loop output 1 to 10
    public static void tenCount(){
        Integer count = 1;
        do
        {
            System.debug(count);
            count++;
        }
        while (count < 11);
    }

    //use of while loop printing factorial of a number
    public static void factorial(Integer value)
    {
        Integer count=1, result=1;
        while(count<=value)
        {
            result=result*count;
            count++;        
        }
        System.debug('factorial of given number is: '+result);
    }

    //use of for loop printing table
    public static void table(Integer value)
    {
       System.debug('displaying the table for '+value);
       for(Integer count=1;count<=10;count++)
       {
           System.debug(value*count); 
       } 
    }

    // use of for each loop to iterating a list
    public static void displayList()
    {
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        for (Integer i : myInts) {
            System.debug(i);
        }
    }
}