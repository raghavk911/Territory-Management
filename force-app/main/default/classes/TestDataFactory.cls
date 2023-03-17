/**  @classname             : TestDataFactory
  *  @author                : Raghavendra Kadam
  *  @date                  : 17-Mar-2023
  *  @description           : This is Test Data Factory class of Territory Management Project 
                              in which required test data has been created
  *  @modification log      : 
  *  1. Raghavendra Kadam   :   Class and comments has written in this class 17-Mar-2023
     2. Raghavendra Kadam   :   Code correction has been done as per review 17-Mar-2023
*/
@isTest
public class TestDataFactory {
/**  @methodname        : createContact
  *  @author            : Raghavendra Kadam
  *  @param             : integer numConts
  *  @description       : This method creates contact for test data
  *  @return            : None
*/
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

/**  @methodname        : terListCountryStateZip
  *  @author            : Raghavendra Kadam
  *  @param             : integer num, Boolean flag
  *  @description       : This method creates territory as country-state-zip
  *  @return            : None
*/
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

/**  @methodname        : terListCountryState
  *  @author            : Raghavendra Kadam
  *  @param             : integer num, Boolean flag
  *  @description       : This method creates territory as country-state-zip
  *  @return            : None
*/
  public Static List<Territory__c> terListCountryState(Integer num, Boolean flag)
  {
    List<Territory__c> territoryList = new List<Territory__c>();
     for(Integer i = 0 ; i < num ; i++)
     {
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

/**  @methodname        : terListCountry
  *  @author            : Raghavendra Kadam
  *  @param             : integer num, Boolean flag
  *  @description       : This method creates territory as country-state-zip
  *  @return            : None
*/
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