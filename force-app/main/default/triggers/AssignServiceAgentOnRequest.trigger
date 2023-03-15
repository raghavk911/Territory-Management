trigger AssignServiceAgentOnRequest on Service_Request__c (before insert, after insert, before update, after update) {
    if(Trigger.isBefore && Trigger.isInsert){
       // AssignServiceAgentTerritoryManagement.populateOwner(Trigger.New);
       serviceReqTriggerHandler.populateOwner(Trigger.New);
      }

}