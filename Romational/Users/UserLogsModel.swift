//
//  UserLogsModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 6/14/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class UserLogsModel: NSObject {
    
    //properties
    
    var prescreenStarted:     String?
    var prescreenCompleted:   String?
    var romtypeStarted:       String?
    var romtypeCompleted:     String?
    var flexibilityStarted:   String?
    var flexibilityCompleted: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(prescreenStarted: String, prescreenCompleted: String, romtypeStarted: String, romtypeCompleted: String, flexibilityStarted: String, flexibilityCompleted: String) {
        
        self.prescreenStarted       = prescreenStarted
        self.prescreenCompleted     = prescreenCompleted
        self.romtypeStarted         = romtypeStarted
        self.romtypeCompleted       = romtypeCompleted
        self.flexibilityStarted     = flexibilityStarted
        self.flexibilityCompleted   = flexibilityCompleted
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "prescreenStarted: \(prescreenStarted),  prescreenCompleted: \(prescreenCompleted), romtypeStarted: \(romtypeStarted), romtypeCompleted: \(romtypeCompleted), flexibilityStarted: \(flexibilityStarted), flexibilityCompleted: \(flexibilityCompleted)"
        
    }
    
    
}
