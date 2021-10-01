//
//  RomtypeListModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class RomtypeListModel: NSObject {
    
    //properties
    
    var id: Int?
    var order: Int?
    var name: String?
    var code: String?
    var image: String?
    var definition: String?
    var info: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, order: Int, name: String, code: String, image: String, definition: String, info: String) {
        
        self.id         = id
        self.order      = order
        self.name       = name
        self.code       = code
        self.image      = image
        self.definition = definition
        self.info       = info
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(id), Order: \(order), Name: \(name), Code: \(code), Image: \(String(describing: image)), Definition: \(describing: definition), Info: \(String(describing: info))"
        
    }
    
    
}
