@isTest
public class ServiceReqTriggerHandlerTest {
  @TestSetup
  static void makeData(){
      List<Territory__c> terList = TestDataFactory.terListCountry(1, true);
      List<Territory_Configuration__c> terConfigCountry = new List<Territory_Configuration__c>();
      for(Integer i=0; i<terList.size(); i++) {
        for(Territory__c ter : terList){
        //System.debug('@@@   ter ==='+ter);

        Territory_Configuration__c tr = new Territory_Configuration__c();
        tr.Territory__c = ter.Id;
        tr.Service__c = 'Plumbing';
        terConfigCountry.add(tr);
        //System.debug('@@    tr TerritoryConfiguration record  ==='+tr);
        }
      }
      insert terConfigCountry; 
  }
  @isTest
  public static void populateOwnerTest(){

      List<Territory_Configuration__c> terConfigSetUp = [Select Id, OwnerId from Territory_Configuration__c];
      //System.debug('@@    terConfigSetUp  ===='+terConfigSetUp);

      List<Contact> conList = TestDataFactory.createContact(1);
      //System.debug('@@ conList    ==='+conList);

     List<Service_Request__c> serList = new List<Service_Request__c>();
      for(Contact con : conList){
          for(Territory_Configuration__c terConfig : terConfigSetUp){
              Service_Request__c ser = new Service_Request__c();
              System.debug('Inside for loop');
              ser.Contact__c = con.id;
              //ser.OwnerId = terConfig.OwnerId;
              ser.Territory_Configuration__c = terConfig.Id;
              System.debug('@@    ser.Territory_Configuration__c ===='+ser.Territory_Configuration__c);
              ser.Service__c = 'Plumbing';
              serList.add(ser);
          }

      }
      insert serList;
      ServiceReqTriggerHandler.populateOwner(serList);

      //sr.OwnerId = tc.OwnerId;
      String OwnerIdTerConfigFromTestSetUp = [Select Id, OwnerId from Territory_Configuration__c].OwnerId;
      String ServiceRequestOwnerId = serList[0].OwnerId;
      System.assertEquals(OwnerIdTerConfigFromTestSetUp, ServiceRequestOwnerId);

      //sr.Territory_Configuration__c = tc.Id;
      String terConfigIdInSerList = serList[0].Territory_Configuration__c;
      String recordIdTerConfigFromTestSetUp = [Select Id, OwnerId from Territory_Configuration__c].Id;
      System.assertEquals(recordIdTerConfigFromTestSetUp, terConfigIdInSerList);
  }
}