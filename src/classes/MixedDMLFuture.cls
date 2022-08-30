public class MixedDMLFuture {
    public static void useFutureMethod() {
        // First DML operation
        Account acc = new Account(Name='Future Account');
        insert acc;
        
        // This next operation (insert a user with a role) 
        // can't be mixed with the previous insert unless 
        // it is within a future method. 
        // Call future method to insert a user with a role.
        Util.insertUserWithRole('leena.ahuja@fexle.com', 'mruiz', 'leena.ahuja@fexle.comom', 'Ruiz');        
    }
}