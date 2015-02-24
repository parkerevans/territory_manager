//
//  TerritoryLog.swift
//  TerritoryManager
//
//  Created by Administrator on 12/25/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import Foundation

class TerritoryLog {
    var territoryId : Int?
    var checkinDate : AnyObject?
    var checkoutDate : NSDate?
    var publisherId : String?
    
    init() {
        
    }
    
    // We will use this function in the future
    func toJSON() -> String {
        return ""
    }
    
}