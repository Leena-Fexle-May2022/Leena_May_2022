public class Util {
	@future
    public static void insertUserWithRole(
        String uname, String al, String em, String lname) {
        Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        UserRole role = [SELECT Id FROM UserRole WHERE Name='COO'];
        // Create new user with a non-null user role ID 
        User user = new User(alias = al, email=em, emailencodingkey='UTF-8', lastname=lname, languagelocalekey='en_US', localesidkey='en_US', profileid = profile.Id, userroleid = role.Id,
                             timezonesidkey='America/Los_Angeles', username=uname);
        insert user;
    }
}