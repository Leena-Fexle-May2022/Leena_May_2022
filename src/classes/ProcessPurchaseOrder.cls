public with sharing class ProcessPurchaseOrder {
    public ProcessPurchaseOrder(){
        //Purchase order objects created for employee and customer
        PurchaseOrder order1 = new CustomerPurchaseOrder();
        PurchaseOrder order2 = new EmployeePurchaseOrder();
        processOrder(order1);
        processOrder(order2);
    }

    //display discount according to the type of order is called
    public void processOrder(PurchaseOrder order){
        if(order instanceOf CustomerPurchaseOrder)
        {
            System.debug('check discount for Customer: '+order.discount());
        }
        else
        {
            System.debug('check discount for Employee: '+order.discount());
        }
       
    }
}