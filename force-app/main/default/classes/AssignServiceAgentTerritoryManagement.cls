public with sharing class AssignServiceAgentTerritoryManagement {
    public static void populateOwnerOneParam(List<Service_Request__c> serList){
        List<Contact> conList = [select Id, MailingCountry, MailingPostalCode, MailingState from Contact];
        List<Territory_Configuration__c> terConfig = [select Id, Territory__r.Country__c,  Territory__r.State__c, Territory__r.Zip_Code__c from Territory_Configuration__c ];
        
        List<Group> countryQueue = [select Id, Name from Group where Name = 'United States of America' and Type = 'Queue'];
        
        List<Group> californiaTerritory = [select Id, Name from Group where Name = 'California Territory' and Type = 'Queue'];
        List<Group> michiganTerritory = [select Id, Name from Group where Name = 'Michigan Territory' and Type = 'Queue'];
        List<Group> northCarolinaTerritory = [select Id, Name from Group where Name = 'North Carolina Territory' and Type = 'Queue'];
        List<Group> floridaTerritory = [select Id, Name from Group where Name = 'Florida Territory' and Type = 'Queue'];
        List<Group> texasTerritory = [select Id, Name from Group where Name = 'Texas Territory' and Type = 'Queue'];
        List<Group> washingtonTerritory = [select Id, Name from Group where Name = 'Washington Territory' and Type = 'Queue'];

        for(Service_Request__c ser : serList){
            for(Contact con : conList){
                for(Territory_Configuration__c ter : terConfig){
                    if(con.MailingCountry == ter.Territory__r.Country__c && con.MailingState == Null && con.MailingPostalCode == Null){
                        for(Group country : countryQueue){
                            ser.OwnerId = country.Id;
                        }
                    }
                    else if(con.MailingCountry == ter.Territory__r.Country__c && con.MailingState == ter.Territory__r.State__c && con.MailingPostalCode == Null){
                        if(con.MailingState == 'California'){
                            for(Group california : californiaTerritory){
                                ser.OwnerId = california.Id;
                            }
                        }
                        else if(con.MailingState == 'Michigan'){
                            for(Group michigan : michiganTerritory){
                                ser.OwnerId = michigan.Id;
                            }
                        }
                        else if(con.MailingState == 'Washington'){
                            for(Group washington : washingtonTerritory){
                                ser.OwnerId = washington.Id;
                            }
                        }
                        else if(con.MailingState == 'North Carolina'){
                            for(Group northCarolina : northCarolinaTerritory){
                                ser.OwnerId = northCarolina.Id;
                            }
                        }
                        else if(con.MailingState == 'Florida'){
                            for(Group florida : floridaTerritory){
                                ser.OwnerId = florida.Id;
                            }
                        }
                        else if(con.MailingState == 'Texas'){
                            for(Group texas : texasTerritory){
                                ser.OwnerId = texas.Id;
                            }
                        }
                    }
                }
            }
        }
    }
}