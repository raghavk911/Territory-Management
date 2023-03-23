/**  @classname             : ServiceReqTriggerHandler
  *  @author                : Raghavendra Kadam
  *  @date                  : 15-Mar-2023
  *  @description           : This is Handler class of Trigger AssignServiceAgentOnRequest in which logic has written as 
                              assignment service agent using queue respective to their Territories.
  *  @modification log      : 
  *  1. Raghavendra Kadam   :   Class and comments has written in this class 15-Mar-2023
     2. Raghavendra Kadam   :   Code correction has been done as per review 17-Mar-2023
*/
public without sharing class ServiceReqTriggerHandler {

/**  @methodname        : populateOwner
  *  @author            : Raghavendra Kadam
  *  @param             : List<Service_Request__c> as Trigger.New
  *  @description       : This is Trigger Handler class method in which logic for assignment of owner is written
  *  @return            : None
*/
  public static void populateOwner(List<Service_Request__c> newRequests)
  {
    List<String> contactIdList = new List<String>();
    Map<ID, Contact> idVsContactRecordMap = new Map<Id,Contact>();
    
    for(Service_Request__c sr : newRequests)
    {
      if(sr.Contact__c != null)
      {
          contactIdList.add(sr.Contact__c);
      }
    }

    if(contactIdList.size() > 0 ){
      IdVsContactRecordMap = new Map<ID, Contact>([SELECT Id, MailingCountry , MailingState, MailingPostalCode FROM Contact where Id IN : contactIdList]);
    }

    String currentRecordContCountry;
    String currentRecordContState;
    String currentRecordContZip;
    String currentRecordServiceType;

    for(Service_Request__c sr : newRequests)
    {
      currentRecordContCountry = IdVsContactRecordMap.get(sr.Contact__c).MailingCountry;
      currentRecordContState = IdVsContactRecordMap.get(sr.Contact__c).MailingState;
      currentRecordContZip = IdVsContactRecordMap.get(sr.Contact__c).MailingPostalCode;
      currentRecordServiceType = sr.Service__c;
    }

    Boolean isConStateZipPresent = currentRecordContCountry != '' && currentRecordContState != '' && currentRecordContZip != '';
    Boolean isConStatePresent = currentRecordContCountry != '' && currentRecordContState != '' && currentRecordContZip == '';
    Boolean isConPresent = currentRecordContCountry != '' && currentRecordContState == '' && currentRecordContZip == '';
      
    if(isConStateZipPresent || isConStatePresent || isConPresent){
      List<Territory_Configuration__c> terConfigList = [ SELECT Id, OwnerId, Name, Territory__c, Service__c 
      FROM Territory_Configuration__c 
      Where Territory__r.Country__c =: currentRecordContCountry
      AND Territory__r.State__c =: currentRecordContState
      AND Territory__r.Zip_Code__c =: currentRecordContZip
      AND Service__c =: currentRecordServiceType limit 1];

      for(Service_Request__c sr : newRequests){
        if(terConfigList != null)
        {
          for(Territory_Configuration__c tc:terConfigList)
          {
            sr.OwnerId = tc.OwnerId;
            sr.Territory_Configuration__c = tc.Id;
          }
        }
      }
    }
  }
}