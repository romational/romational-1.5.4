//
//  FactorQuestionModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class FactorQuestionModel: NSObject {
    
    //properties
    
    var id: Int?
    var name: String?
    var order: Int?
    var image: String?
    var question: String?
    var info: String?
    var answers: Array<Any>?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, name: String, order: Int, image: String, question: String, info: String, answers: Array<Any>) {
        
        self.id         = id
        self.name       = name
        self.order      = order
        self.image      = image
        self.question   = question
        self.info       = info
        self.answers    = answers
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), Name: \(String(describing: name)), Order: \(String(describing: order)), Image: \(String(describing: image)), Question: \(String(describing: question)), Info: \(String(describing: info)), Answers: \(String(describing: answers))"
        
    }
    
    
}
