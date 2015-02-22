//
//  Territory.swift
//  TerritoryManager
//
//  Created by Administrator on 12/24/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import Foundation

class Territory {
    var territoryId : Int?
    var category : String?
    var status : String?
    var objectId: String?
    var congregationId: String?
    
    init() {
        
    }
    
    // We will use this function in the future
    func toJSON() -> String {
        return ""
    }
    
}