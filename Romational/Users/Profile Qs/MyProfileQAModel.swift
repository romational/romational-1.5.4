//
//  MyProfileModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation



class MyProfileQAModel: NSObject {
    
    //properties
    var pqid : Int?
    var pqaid: Int?
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(pqid: Int, pqaid: Int) {
        
        self.pqid = pqid
        self.pqaid = pqaid
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Question Id: \(pqid), Answer Id: \(pqaid)"
        
    }
    
    
}
