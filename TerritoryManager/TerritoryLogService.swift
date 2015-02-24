//
//  TerritoryLogService.swift
//  TerritoryManager
//
//  Created by Administrator on 12/30/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import Foundation

class TerritoryLogService:NSObject {
    
    override init() {
        super.init()
    }
    
    func getTerritoryLog(PFClassName:String, congregationId:String, currentTerritoryId:Int, callback:(NSArray) -> Void) {
        requestGet(PFClassName, congregationId:congregationId, currentTerritoryId: currentTerritoryId, callback: callback)
        
    }
    
    
    func saveTerritoryLog(PFClassName:String, congregationId:String, currentTerritoryId:Int, checkInDate:AnyObject?, checkOutDate:AnyObject?, chosenPublisher:String, parent:String, action:String) {
        requestSave(PFClassName, congregationId:congregationId, currentTerritoryId: currentTerritoryId, checkInDate: checkInDate, checkOutDate: checkOutDate, chosenPublisher: chosenPublisher, parent: parent, action:action)
        // requestGet(PFClassName, currentTerritoryId: currentTerritoryId, callback: callback)
    }
    
    
    
    func requestSave(PFClassName:String, congregationId:String, currentTerritoryId:Int, checkInDate:AnyObject?, checkOutDate:AnyObject?, chosenPublisher:String, parent:String, action:String) {
        
        var territoryLogQry  = PFQuery(className: PFClassName)
        var queryResults = [AnyObject]()

        if action == "CHECKIN" {
            territoryLogQry.whereKey("territoryId", equalTo:currentTerritoryId)
            println("Check out Date : \(checkOutDate)")
            territoryLogQry.whereKey("checkoutDate", equalTo:checkOutDate)
            queryResults = territoryLogQry.findObjects()
            
            if queryResults.isEmpty {
                println("Territory Log not found!")
            } else {
                for queryResult in queryResults {
                    var object = PFObject(className: PFClassName)
                    object = queryResult as PFObject
                    //object["territoryId"] = currentTerritoryId
                    object["checkinDate"] = checkInDate
                    //object["checkoutDate"] = checkOutDate
                    //object["publisher"] = chosenPublisher
                    object["parent"] = parent
                    //object["user"] = PFUser.currentUser()
                    object.save()
                    
                    self.requestUpdateTerritory("Territory", congregationId:congregationId,currentTerritoryId: currentTerritoryId, status: "In", category: "")
                    NSLog("Successfully saved the check-in object.")
                }
            }
            
        } else {
            var newTerritoryLog = PFObject(className: PFClassName)
            // Saving territory log
            newTerritoryLog["territoryId"] = currentTerritoryId
            newTerritoryLog["checkinDate"] = checkInDate
            newTerritoryLog["checkoutDate"] = checkOutDate
            newTerritoryLog["publisher"] = chosenPublisher
            newTerritoryLog["parent"] = parent
            newTerritoryLog["user"] = PFUser.currentUser()
            newTerritoryLog.save()
            
            self.requestUpdateTerritory("Territory", congregationId:congregationId,currentTerritoryId: currentTerritoryId, status: "Out", category: "")
            
            NSLog("Successfully saved the check-out object.")
        }
        
        
    }
    
    
    func requestGet(PFClassName:String, congregationId:String, currentTerritoryId:Int, callback:(NSArray) -> Void) {
        
        var response = [TerritoryLog]()
        var query = PFQuery(className:PFClassName)
        query.whereKey("territoryId", equalTo:currentTerritoryId)
        query.orderByDescending("checkoutDate")
        query.limit = 300
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) records in the log.")
                // Do something with the found objects
                
                for object in objects {
                    var territoryLog : TerritoryLog = TerritoryLog()
                    territoryLog.territoryId = object["territoryId"] as? Int
                    territoryLog.checkinDate = object["checkinDate"]
                    territoryLog.checkoutDate = object["checkoutDate"] as? NSDate
                    // TODO: Correct Publisher Field with an ID instead of Name
                    territoryLog.publisherId = object["publisher"] as? String
                    response.append(territoryLog)
                    // NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            callback(response)
        }
        

    }
    
   
    func requestUpdateTerritory(PFClassName:String, congregationId:String, currentTerritoryId:Int, status:String, category:String) -> Void {
        let service = TerritoryService()
        service.updateByTerritoryId("Territory", territoryId: currentTerritoryId, status:status, category:category, congregationId: congregationId)
        
    }
    
    
    
    
}