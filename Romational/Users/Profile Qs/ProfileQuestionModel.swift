//
//  ProfileQuestionModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class ProfileQuestionModel: NSObject {
    
    //properties
    
    var id: Int?
    var order: Int?
    var name: String?
    var question: String?
    var answers: Array<Any>?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, order: Int, name: String, question: String, answers: Array<Any>) {
        
        self.id         = id
        self.order      = order
        self.name       = name
        self.question   = question
        self.answers    = answers
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), Order: \(String(describing: order)), Name: \(String(describing: name)), Question: \(String(describing: question)), Answers: \(String(describing: answers))"
        
    }
    
    
}
