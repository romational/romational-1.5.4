//
//  RangeModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 9/8/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation


class RangeModel: NSObject {
    
    //properties
    
    var id: Int?
    var name: String?
    var low: Int?
    var high: Int?
    var ranking: Int?
    var info: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int,  name: String, low: Int, high: Int, ranking: Int, info: String) {
        
        self.id         = id
        self.name       = name
        self.low        = low
        self.high       = high
        self.ranking    = ranking // "default" ranking
        self.info       = info
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), Name: \(String(describing: name)), Low: \(String(describing: low)), High: \(String(describing: high)), Default Ranking: \(String(describing: ranking)),  Info: \(String(describing: info))"
        
    }
    
    
}
