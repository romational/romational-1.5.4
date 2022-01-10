//
//  FactorSelectivityModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class FactorSelectivityModel: NSObject {
    
    //properties
    
    
    var rank: String?
    var total: Int?
    var ids: Array<Any>?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(rank: String, total: Int, ids: Array<Any>) {
        
        self.rank = rank
        self.total = total
        self.ids = ids
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Rank: \(String(describing: rank)), Total: \(String(describing: total)), Ids: \(String(describing: ids))"
        
    }
    
    
}
