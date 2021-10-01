//
//  MyRankedFactorAnswersModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class MyRankedFactorAnswersModel: NSObject {
    
    //properties
    
    var factorId: Int?
    var factorOrder: Int?
    var factorName: String?
    var factorImage: String?
    var selectivity: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(factorId: Int, factorOrder: Int, factorName: String, factorImage: String, selectivity: String) {
        
        self.factorId    = factorId
        self.factorOrder = factorOrder
        self.factorName  = factorName
        self.factorImage = factorImage
        self.selectivity = selectivity
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "FactorId: \(String(describing: factorId)), FactorOrder: \(String(describing: factorOrder)), FactorName: \(String(describing: factorName)), FactorImage: \(String(describing: factorImage)), Selectivity: \( selectivity)"
        
    }
    
    
}
