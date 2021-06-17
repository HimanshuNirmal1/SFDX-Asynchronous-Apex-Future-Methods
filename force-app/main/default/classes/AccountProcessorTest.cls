@isTest

private class AccountProcessorTest {

    @isTest
    private static void countContactTest() {

        //Load the test data

        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 200; i++){
            accounts.add(new Account(Name = 'Test Account' + i));
           
        }
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        List<Id> accountids = new List<Id>();
        for (Account acc : accounts){
            contacts.add(new Contact(FirstName = acc.Name, LastName = 'TestContact', AccountId = acc.Id));
            accountids.add(acc.Id);
        }
        insert contacts;

        //Perform the test
        Test.startTest();
        AccountProcessor.countContacts(accountids);
        Test.stopTest();

        //Check the result
        List<Account> accs = [SELECT Id, Number_Of_Contacts__c FROM Account];
        for(Account acc : accs){
            System.assertEquals(1, acc.Number_Of_Contacts__c, 'ERROR: At least 1 Account record with incorrect data');
        }

    }
}