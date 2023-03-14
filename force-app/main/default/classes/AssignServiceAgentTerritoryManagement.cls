public with sharing class AssignServiceAgentTerritoryManagement {
public static void populateOwnerOneParam(List<Service_Request__c> serList){
    List<Contact> conList = [select Id, MailingCountry, MailingPostalCode, MailingState from Contact];
    List<Territory_Configuration__c> terConfig = [select Id, Territory__r.Country__c,  Territory__r.State__c, Territory__r.Zip_Code__c from Territory_Configuration__c ];
    List<Group> countryQueue = [select Id, Name from Group where Name = 'United States of America' and Type = 'Queue'];
    List<Group> californiaTerritory = [select Id, Name from Group where Name = 'California Territory' and Type = 'Queue'];
    
    List<Service_Request__c> countryServiceList = new List<Service_Request__c>();
    List<Service_Request__c> countryStateServiceList = new List<Service_Request__c>();
    
        for(Contact con : conList){
            for(Territory_Configuration__c ter : terConfig){
                if(con.MailingCountry == ter.Territory__r.Country__c && con.MailingState == Null && con.MailingPostalCode == Null){
                    for(Group country : countryQueue){
                        serList[0].OwnerId=country.Id;
                        Service_Request__c req = new Service_Request__c();
                        req.OwnerId = country.Id;
                        system.debug('@@    country.Id ===='+ country.Id);
                        system.debug('@@    req.OwnerId ===='+ req.OwnerId);
                        countryServiceList.add(req);
                    }
                }
                else if(con.MailingCountry == ter.Territory__r.Country__c && con.MailingState == ter.Territory__r.State__c && con.MailingPostalCode == Null){
                    system.debug('@@    else if====');
                    Service_Request__c req = new Service_Request__c();
                    for(Group california : californiaTerritory){
                        serList[0].OwnerId=california.Id;
                    req.OwnerId = california.Id;
                    system.debug('@@    req.OwnerId ===='+ req.OwnerId);
                    system.debug('@@    california.Id ===='+ california.Id);
                    countryStateServiceList.add(req);
                    }
                }
            }
        
        }
    
    }

}