//
//  RomtypeListModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class MyRomtypeDataModel: NSObject {
    
    //properties
    
    var id: Int?
    var order: Int?
    var name: String?
    var image: String?
    var answer: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, order: Int, name: String, image: String, answer: String) {
        
        self.id             = id
        self.order          = order
        self.name           = name
        self.image          = image
        self.answer         = answer
   
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), Order: \(String(describing: order)), Name: \(String(describing: name)),  Image: \(String(describing: image)), Answer: \(String(describing: answer))"
        
    }
    
    
}
