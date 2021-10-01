//
//  RomtypeWeightsModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class RomtypeWeightsModel: NSObject {
    
    //properties
    
    var type: String?
    var percent: Int?

    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init( type: String, percent: Int) {
        
        self.type       = type
        self.percent    = percent
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return " Type: \(String(describing: type)), Percent: \(String(describing: percent))"
        
    }
    
    
}
