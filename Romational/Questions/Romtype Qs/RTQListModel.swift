//
//  RTQListModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class RTQListModel: NSObject {
    
    //properties
    
    var id: Int?
    var order: Int?
    var name: String?
    var image: String?
    var info: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, order: Int, name: String, image: String, info: String) {
        
        self.id     = id
        self.order  = order
        self.name   = name
        self.image  = image
        self.info   = info
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(id), Order: \(order), Name: \(name), Image: \(String(describing: image)), Info: \(String(describing: info))"
        
    }
    
    
}
