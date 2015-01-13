//
//  Territory.swift
//  TerritoryManager
//
//  Created by Administrator on 12/24/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import Foundation

class Territory: NSObject {
    var territoryId : String?
    var category : String?
    var status : String?
    var objectId: String?
    
    override init() {
        super.init()
    }
    
    init(territoryId:String, category:String, status:String, objectId:String?) {
        super.init()
        self.territoryId = territoryId
        self.category = category
        self.status = status
        self.objectId = objectId
    }
    
    
    // We will use this function in the future
    func toJSON() -> String {
        return ""
    }
    
}