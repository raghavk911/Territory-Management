@isTest
public class TestDataFactory {
    public static List<Contact> createContact(integer numConts) 
    {
        List<Contact> cont = new List<Contact>();
        for(Integer i=0;i<numConts;i++) {
            Contact obj = new Contact();
            obj.FirstName='FirstName '+i;
            obj.LastName='LastName '+ i;
            obj.MailingPostalCode =' ';
            obj.MailingState =' ';
            obj.MailingCountry='United States of America';
            cont.add(obj);
        }
        insert cont;
        return cont;
    }

     public Static List<Territory__c> terListCountryStateZip(Integer num, Boolean flag)
     {
        List<Territory__c> territoryList = new List<Territory__c>();
         for(Integer i = 0 ; i < num ; i++)
         {
            Territory__c ter = new Territory__c();
            ter.Country__c = 'United States of America'; 
            ter.State__c = 'California';
            ter.Zip_Code__c = '28247';
            territoryList.add(ter);
         }

        if(Flag == true)
        {
            insert territoryList;
        }
        return territoryList;
    }

    public Static List<Territory__c> terListCountryState(Integer num, Boolean flag)
    {
        List<Territory__c> territoryList = new List<Territory__c>();
         for(Integer i = 0 ; i < num ; i++){
            Territory__c ter = new Territory__c();
            ter.Country__c = 'United States of America'; 
            ter.State__c = 'California';
            ter.Zip_Code__c = '';
            territoryList.add(ter);
         }

        if(Flag == true)
        {
            insert territoryList;
        }
        return territoryList;
    }

    public Static List<Territory__c> terListCountry(Integer num, Boolean flag)
    {
        List<Territory__c> territoryList = new List<Territory__c>();
         for(Integer i = 0 ; i < num ; i++)
         {
            Territory__c ter = new Territory__c();
            ter.Country__c = 'United States of America'; 
            ter.State__c = ' ';
            ter.Zip_Code__c = ' ';
            territoryList.add(ter);
         }

        if(Flag == true)
        {
            insert territoryList;
        }
        return territoryList;
    }
}