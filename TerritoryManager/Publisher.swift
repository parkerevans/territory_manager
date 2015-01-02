//
//  Publisher.swift
//  TerritoryManager
//
//  Created by Administrator on 12/22/14.
//  Copyright (c) 2014 PrivateJets. All rights reserved.
//

import UIKit

class Publisher: NSObject {
    var publisherId : String?
    var firstName : String?
    var lastName : String?
    var baptismDate : NSDate?
    var fullName : String?
    
    init(publisherId:String, firstName:String, lastName:String) {
        self.publisherId = publisherId
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = firstName + " " + lastName
        super.init()
    }
    
}