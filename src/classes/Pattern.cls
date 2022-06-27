public with sharing class Pattern
{
    public static void leftPascalTriangle() 
    {
        Integer rows,column;
        String print;
        for(rows=1;rows<=9;rows++)
        {
	        print='';
            if(rows<=5)
            {
	            for(column=1;column<=5;column++)
	            {
		            if(column<=5-rows)
			            print='_'+print;  
		            else
			            print=print+'*';
	            }
	            System.debug(print);
            }
            else
            {
                for(column=6;column<=10;column++)
                {
                    if(column<=rows)
                        print='_'+print; 
                    else
                        print=print+'*';
                }
                System.debug(print);
            }   
        }
    }
    public static void downTraingle()
    {
        Integer rows,column;
        String print;
        for(rows=1;rows<=5;rows++)
        {
	        print='';
	        for(column=1;column<=9;column++)
	        {
		        if(rows==1)
			        print='*'+print;  
		        else
                {   
                    if(rows==column || column==10-rows)
			            print='*'+print;
                    else
                        print='_'+print;
                }

	        }
	        System.debug(print);
        }
    }
    public static void leftTriangle()
    {
        Integer rows,column;
        String print;
        for(rows=1;rows<=5;rows++)
        {
	        print='';
	        for(column=1;column<=5;column++)
	        {
		        if(column<=5-rows)
			        print='_'+print;  
		        else
			        print=print+'*';
	        }
	        System.debug(print);
        }
    }
    public static void downwardTriangle()
    {
        Integer rows,column;
        String print;
        for(rows=1;rows<=5;rows++)
        {
	        print='';
	        for(column=1;column<=5;column++)
	        {
		        if(column<rows)
			        print='_'+print;  
		        else
			        print=print+'*';
	        }
	        System.debug(print);
        }
    }
    public static void leftPascalTriangle(Integer rows) 
    {
        if(math.mod(rows,2)!=0)
        {
            Integer rowcount,column,halfrow=rows/2;
            String print;
            for(rowcount=1;rowcount<=rows;rowcount++)
            {
                print='';
                if(rowcount<=halfrow)
                {
                    for(column=1;column<=halfrow+1;column++)
                    {
                        if(column<=(halfrow+1)-rowcount)
                            print='_'+print;  
                        else
                            print=print+'*';
                    }
                    System.debug(print);
                }
                else
                {
                    for(column=halfrow+2;column<=rows+1;column++)
                    {
                        if(column<=rowcount)
                            print='_'+print; 
                        else
                            print=print+'*';
                    }
                    System.debug(print);
                }  
            } 
        }
        else
            System.debug('enter odd number of rows');
    }
    
    public static void downTraingle(Integer rows)
    {
        if(math.mod(rows,2)!=0)
        {
            Integer rowcount,column,doublerow=rows*2;
            String print;
            for(rowcount=1;rowcount<=rows;rowcount++)
            {
                print='';
                for(column=1;column<=doublerow-1;column++)
                {
                    if(rowcount==1)
                        print='*'+print;  
                    else
                    {   
                        if(rowcount== column|| column==doublerow-rowcount)
                            print='*'+print;
                        else
                            print='_'+print;
                    }

                }
                System.debug(print);
            }
        }
        else
            System.debug('enter odd number of rows');
    }
    public static void leftTriangle(Integer rows)
    {
        Integer rowcount,column;
        String print;
        for(rowcount=1;rowcount<=rows;rowcount++)
        {
            print='';
            for(column=1;column<=rows;column++)
            {
                if(column<=rows-rowcount)
                    print='_'+print;  
                else
                    print=print+'*';
            }
            System.debug(print);
        }
    } 
    public static void downwardTriangle(Integer rows)
    {
        Integer rowcount,column;
        String print;
        for(rowcount=1;rowcount<=rows;rowcount++)
        {
            print='';
            for(column=1;column<=rows;+column++)
            {
                if(column<rowcount)
                    print='_'+print;  
                else
                    print=print+'*';
            }
            System.debug(print);
        }
    }
   
}