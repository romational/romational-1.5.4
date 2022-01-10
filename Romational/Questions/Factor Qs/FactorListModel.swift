//
//  FactorListModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class FactorListModel: NSObject {
    
    //properties
    
    var id: Int?
    var name: String?
    var order: Int?
    var image: String?
    var info: String?
    var beforeImage: String?
    var beforeTitle: String?
    var beforeText: String?
    var beforeButton: String?
    
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, name: String, order: Int, image: String, info: String, beforeImage: String, beforeTitle: String, beforeText: String, beforeButton: String) {
        
        self.id             = id
        self.name           = name
        self.order          = order
        self.image          = image
        self.info           = info
        self.beforeImage    = beforeImage
        self.beforeTitle    = beforeTitle
        self.beforeText     = beforeText
        self.beforeButton   = beforeButton
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)) Name: \(String(describing: name)), Order: \(String(describing: order)), Image: \(String(describing: image)), Info: \(String(describing: info)), Before Image: \(String(describing: beforeImage)), Before Title: \(String(describing: beforeTitle)), Before Text: \(String(describing: beforeText)), Before Button: \(String(describing: beforeButton))"
        
    }
    
    
}
