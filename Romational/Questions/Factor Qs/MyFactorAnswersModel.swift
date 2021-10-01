//
//  RomtypeListModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class MyFactorAnswersModel: NSObject {
    
    //properties
    
    var factorId: String?
    var answerId: String?
    var selectivity: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(factorId: String, answer: String, selectivity: String) {
        
        self.factorId = factorId
        self.answerId = answer
        self.selectivity = selectivity
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "FactorId: \(String(describing: factorId)) AnswerId: \(String(describing: answerId)), Selectivity: \( selectivity)"
        
    }
    
    
}
