/**  @classname             : ServiceReqTriggerHandlerTest
  *  @author                : Raghavendra Kadam
  *  @date                  : 17-Mar-2023
  *  @description           : This is Test Class of ServiceReqTriggerHandler class in which assignment of Service Agent 
                              as owner from queue logic and assiging territory configuration record logic have tested
  *  @modification log      : 
  *  1. Raghavendra Kadam   :   Class and comments has written in this class 17-Mar-2023
     2. Raghavendra Kadam   :   Code correction has been done as per review 17-Mar-2023
*/
@isTest
public class ServiceReqTriggerHandlerTest {
/**  @methodname        : makeData
  *  @author            : Raghavendra Kadam
  *  @description       : This is TestSetUp method create Territory configuration data
*/
  @TestSetup
  static void makeData(){
      List<Territory__c> terList = TestDataFactory.terListCountry(1, true);
      List<Territory_Configuration__c> terConfigCountry = new List<Territory_Configuration__c>();

      for(Integer i=0; i<terList.size(); i++) 
      {
        for(Territory__c ter : terList)
        {
          Territory_Configuration__c tr = new Territory_Configuration__c();
          tr.Territory__c = ter.Id;
          tr.Service__c = 'Plumbing';
          terConfigCountry.add(tr);
        }
      }
      insert terConfigCountry; 
  }

/**  @methodname        : populateOwnerTest
  *  @author            : Raghavendra Kadam
  *  @description       : This is test method test logic for service agent assignment as record owner
*/
  @isTest
  public static void populateOwnerTest(){
    List<Territory_Configuration__c> terConfigSetUp = [Select Id, OwnerId from Territory_Configuration__c];
    List<Contact> conList = TestDataFactory.createContact(1);

    List<Service_Request__c> serList = new List<Service_Request__c>();
    for(Contact con : conList)
    {
      for(Territory_Configuration__c terConfig : terConfigSetUp)
      { 
        Service_Request__c ser = new Service_Request__c();
        ser.Contact__c = con.id;
        ser.Territory_Configuration__c = terConfig.Id;
        ser.Service__c = 'Plumbing';
        serList.add(ser);
      }
    }
    insert serList;
    ServiceReqTriggerHandler.populateOwner(serList);

    String OwnerIdTerConfigFromTestSetUp = [Select Id, OwnerId from Territory_Configuration__c].OwnerId;
    String ServiceRequestOwnerId = serList[0].OwnerId;
    System.assertEquals(OwnerIdTerConfigFromTestSetUp, ServiceRequestOwnerId);

    String terConfigIdInSerList = serList[0].Territory_Configuration__c;
    String recordIdTerConfigFromTestSetUp = [Select Id, OwnerId from Territory_Configuration__c].Id;
    System.assertEquals(recordIdTerConfigFromTestSetUp, terConfigIdInSerList);
  }
}