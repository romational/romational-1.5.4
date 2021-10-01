//
//  RomtypeQuestionModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class RomtypeQuestionModel: NSObject {
    
    //properties
    
    var id: Int?
    var order: Int?
    var name: String?
    var image: String?
    var question: String?
    var info: String?
    var answers: Array<Any>?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, order: Int, name: String, image: String, question: String, info: String, answers: Array<Any>) {
        
        self.id         = id
        self.order      = order
        self.name       = name
        self.image      = image
        self.question   = question
        self.info       = info
        self.answers    = answers
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), Order: \(String(describing: order)), Name: \(String(describing: name)),  Image: \(String(describing: image)), Question: \(String(describing: question)), Info: \(String(describing: info)), Answers: \(String(describing: answers))"
        
    }
    
    
}
