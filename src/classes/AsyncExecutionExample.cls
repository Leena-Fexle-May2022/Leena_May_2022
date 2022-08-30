public class AsyncExecutionExample implements Queueable {
    public void execute(QueueableContext context) {
        Account acc = new Account(Name='Account Queue',Phone='(415) 555-1212');
        insert acc;        
    }
}