/**  @triggername           : AssignServiceAgentOnRequest
  *  @author                : Raghavendra Kadam
  *  @date                  : 15-Mar-2023
  *  @description           : This is Trigger of serviceReqTriggerHandler class responsible for populate
                              owner on Service request object in owner field 
  *  @modification log      : 
  *  1. Raghavendra Kadam   :   Apex Trigger and comments has been added dated on 15-Mar-2023
  *  2. Raghavendra Kadam   :   Apex Trigger naming convention has corrected as per standards dated on 17-Mar-2023
*/
trigger AssignServiceAgentOnRequest on Service_Request__c (before insert) {
  if(Trigger.isBefore && Trigger.isInsert)
  {
    //ServiceReqTriggerHandler.populateOwner(Trigger.New);
    //ServiceReqTriggerHandler2.populateOwner(Trigger.New);
    ServiceReqTriggerHandler3.populateOwner(Trigger.New);
  }

  /*if(Trigger.isAfter && Trigger.isInsert)
  {
    //ServiceReqTriggerHandler.populateOwner(Trigger.New);
    ServiceReqTriggerHandler2.populateOwner(Trigger.New);
  }*/
}