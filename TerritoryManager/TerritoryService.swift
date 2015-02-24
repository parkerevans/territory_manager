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
    
    func getTerritory(PFClassName:String, congregationId:String, callback:(NSArray) -> Void) {
        println("Congregation# \(congregationId)")
        requestGet(PFClassName, congregationId:congregationId, callback: callback)
    }
    
    func saveTerritory(PFClassName:String, id:Int, status:String, category:String, congregationId:String, callback:(NSArray)->Void) {
        
        println("Congregation# \(congregationId)")
        requestSave(PFClassName, id: id, status:status, category:category, congregationId:congregationId)
        requestGet(PFClassName, congregationId:congregationId, callback: callback)
    }
    
    func updateByTerritoryId(PFClassName:String, territoryId:Int, status:String, category:String, congregationId:String) {
        
        requestUpdateByTerritoryId(PFClassName, territoryId: territoryId, status: status, category: category, congregationId:congregationId)
    }
    
    func requestSave(PFClassName:String, id:Int, status:String, category:String, congregationId:String) {
        
        let territory = PFObject(className: PFClassName)
        var error:NSError?
        
        territory["territoryId"] = id
        territory["congregationId"] = congregationId
        territory["status"] = status
        territory["category"] = category
        territory["creator"] = PFUser.currentUser()
        territory.saveEventually()
    
    }
    
    func requestGet(PFClassName:String, congregationId:String, callback:(NSArray) -> Void) {
        
        var response = [Territory]()
        var query = PFQuery(className:PFClassName)
        // query.whereKey("status", equalTo:"Available")
        query.limit = 300
        query.whereKey("congregationId", equalTo: congregationId)
        query.orderByAscending("territoryId")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                // NSLog("Successfully retrieved \(objects.count) territories.")
                
                for object in objects {
                    var territory:Territory = Territory()
                    territory.territoryId = (object["territoryId"] as Int)
                    territory.status = object["status"] as? String
                    territory.category = object["category"] as? String
                    territory.congregationId = object["congregationId"] as? String
                    territory.objectId = object.objectId
                    response.append(territory)
                    // println("Array territory objectId is: \(territory.objectId)")
                    // NSLog("%@", object.objectId)
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }

            callback(response)

        }

    }
    
    func requestUpdateByTerritoryId(PFClassName:String, territoryId:Int, status:String, category:String, congregationId:String) {
        
        // var response = [Territory]()
        var query = PFQuery(className:PFClassName)
        var queryResults = [AnyObject]()
        query.whereKey("territoryId", equalTo:territoryId)
        query.whereKey("congregationId", equalTo: congregationId)
        query.limit = 1
        queryResults = query.findObjects()
        if queryResults.isEmpty {
            println("Territory \(territoryId) Congregation \(congregationId) Not Found!")
        } else {
            for queryResult in queryResults {
                var object = PFObject(className: PFClassName)
                object = queryResult as PFObject
                //object["territoryId"] = currentTerritoryId
                //object["congregationId"] = congregationId
                //object["category"] = category
                object["status"] = status
                object.saveEventually()
                
            }
            
        }
        
    }
    
    
}