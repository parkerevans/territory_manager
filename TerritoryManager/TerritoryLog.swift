//
//  TerritoryLog.swift
//  TerritoryManager
//
//  Created by Administrator on 12/25/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import Foundation

class TerritoryLog: NSObject {
    var territoryId : String?
    var checkinDate : NSDate?
    var checkoutDate : NSDate?
    var publisherId : String?
    
    override init() {
        super.init()
    }
    
    init(territoryId:String, checkDate:NSDate, publisherId:String, action:String) {
        self.territoryId = territoryId
        if action == "IN" {
            self.checkinDate = checkDate
        } else {
            self.checkoutDate = checkDate
            self.checkinDate = nil
        }

        self.publisherId = publisherId
        super.init()
    }
    
    // We will use this function in the future
    func toJSON() -> String {
        return ""
    }
    
}