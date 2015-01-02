//
//  TerritoryService.swift
//  TerritoryManager
//
//  Created by Administrator on 12/30/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import Foundation

class TerritoryService : NSObject {
    
    override init() {
        super.init()
    }
    
    func getTerritory(PFClassName:String, callback:(NSArray) -> Void) {
        
        requestGet(PFClassName, callback: callback)
    }
    
    func saveTerritory(PFClassName:String, id:String, callback:(NSArray)->Void) {
        
        requestSave(PFClassName, id: id)
        requestGet(PFClassName, callback: callback)
    }
    
    func requestSave(PFClassName:String, id:String) {
        
        let territory = PFObject(className: PFClassName)
        var error:NSError?
        
        territory["territoryId"] = id
        territory["status"] = "Available"
        territory["category"] = "Regular"
        territory["creator"] = PFUser.currentUser()
        territory.saveEventually()
    
    }
    
    func requestGet(PFClassName:String, callback:(NSArray) -> Void) {
        
        var response = [Territory]()
        var query = PFQuery(className:PFClassName)
        // query.whereKey("status", equalTo:"Available")
        query.limit = 300
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) territories.")
                // Do something with the found objects
                
                for object in objects {
                    var territory : Territory = Territory()
                    territory.territoryId = object["territoryId"] as? String
                    territory.status = object["status"] as? String
                    territory.category = object["category"] as? String
                    response.append(territory)
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