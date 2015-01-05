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
    
    func getTerritoryLog(PFClassName:String, currentTerritoryId:String, callback:(NSArray) -> Void) {
        
        requestGet(PFClassName, currentTerritoryId: currentTerritoryId, callback: callback)
        
    }
    
    func saveTerritoryLog(PFClassName:String, currentTerritoryId:String, checkInDate:AnyObject?, checkOutDate:AnyObject?, chosenPublisher:String, callback:(NSArray) -> Void) {
        requestSave(PFClassName, currentTerritoryId: currentTerritoryId, checkInDate: checkInDate, checkOutDate: checkOutDate, chosenPublisher: chosenPublisher)
        requestGet(PFClassName, currentTerritoryId: currentTerritoryId, callback: callback)
    }
    
    func requestSave(PFClassName:String, currentTerritoryId:String, checkInDate:AnyObject?, checkOutDate:AnyObject?, chosenPublisher:String) {
        
        var newTerritoryLog  = PFObject(className: PFClassName)
        var newTerritory = PFObject(className: "Territory")
        var territoryQry = PFQuery(className: "Territory")
        territoryQry.whereKey("territoryId", equalTo:currentTerritoryId)
        territoryQry.limit = 1
        territoryQry.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) territories.")
                // Do something with the found objects
                
                println("This is the first object: \(objects[0].objectId)")
                // Saving territory log
                newTerritoryLog["territoryId"] = currentTerritoryId
                newTerritoryLog["checkinDate"] = checkInDate
                newTerritoryLog["checkoutDate"] = checkOutDate
                newTerritoryLog["publisher"] = chosenPublisher
                newTerritoryLog["parent"] = objects[0].objectId
                newTerritoryLog["user"] = PFUser.currentUser()
                newTerritoryLog.saveEventually()
                
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

        
    }
    
    func requestGet(PFClassName:String, currentTerritoryId:String, callback:(NSArray) -> Void) {
        
        var response = [TerritoryLog]()
        var query = PFQuery(className:PFClassName)
        query.whereKey("territoryId", equalTo:currentTerritoryId)
        query.orderByDescending("checkinDate")
        query.limit = 300
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) records in the log.")
                // Do something with the found objects
                
                for object in objects {
                    var territoryLog : TerritoryLog = TerritoryLog()
                    territoryLog.territoryId = object["territoryId"] as? String
                    territoryLog.checkinDate = object["checkinDate"]
                    territoryLog.checkoutDate = object["checkoutDate"] as? NSDate
                    // TODO: Correct Publisher Field with an ID instead of Name
                    territoryLog.publisherId = object["publisher"] as? String
                    response.append(territoryLog)
                    NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
            callback(response)
        }

        

    }
}