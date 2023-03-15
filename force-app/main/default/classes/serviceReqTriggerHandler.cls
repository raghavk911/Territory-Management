/**  @classname             : serviceReqTriggerHandler
  *  @author                : Raghavendra Kadam
  *  @date                  : 15-03-2023
  *  @description           : This is Handler class of Trigger AssignServiceAgentOnRequest in which logic has written as 
                              assignment service agent using queue respective to their Territories.
  *  @modification log      : 
  *  1. Raghavendra Kadam   :   Class and comments has written in this class
*/
public class serviceReqTriggerHandler {

/**  @methodname        : populateOwner
  *  @author            : Raghavendra Kadam
  *  @param             : List<Service_Request__c> as Trigger.New
  *  @description       : This is Trigger Handler class method in which logic for assignment of owner is written
  *  @return            : None
*/
    public static void populateOwner(List<Service_Request__c> newRequests){
        List<String> contactIdList = new List<String>();
        Map<ID, Contact> IdVsContactRecordMap = new Map<Id,Contact>();
        
        for(Service_Request__c sr : newRequests){
            if(sr.Contact__c != null){
                contactIdList.add(sr.Contact__c);
            }
        }
        if(contactIdList.size() > 0 ){
            IdVsContactRecordMap = new Map<ID, Contact>([SELECT Id, MailingCountry , MailingState, MailingPostalCode FROM Contact where Id IN : contactIdList]);
        }
        
        for(Service_Request__c sr : newRequests){
            Territory_Configuration__c tc = new Territory_Configuration__c();
            if(IdVsContactRecordMap.get(sr.Contact__c).MailingCountry != '' && IdVsContactRecordMap.get(sr.Contact__c).MailingState != '' && IdVsContactRecordMap.get(sr.Contact__c).MailingPostalCode != '')
                tc = [ SELECT Id, OwnerId, Name, Territory__c, Service__c 
                      FROM Territory_Configuration__c 
                      Where Territory__r.Country__c =: IdVsContactRecordMap.get(sr.Contact__c).MailingCountry
                      AND Territory__r.State__c =: IdVsContactRecordMap.get(sr.Contact__c).MailingState
                      ANd Territory__r.Zip_Code__c =: IdVsContactRecordMap.get(sr.Contact__c).MailingPostalCode
                      AND Service__c =: sr.Service__c limit 1];
            
            if(tc != null){
                sr.OwnerId = tc.OwnerId;
                sr.Territory_Configuration__c = tc.Id;
            }
        }
        
    }
}