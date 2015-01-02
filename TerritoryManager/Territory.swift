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
    
    override init() {
        super.init()
    }
    
    init(territoryId:String, category:String, status:String) {
        self.territoryId = territoryId
        self.category = category
        self.status = status
        super.init()
    }
    
    
    // We will use this function in the future
    func toJSON() -> String {
        return ""
    }
    
}