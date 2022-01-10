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
    var beforeImage: String?
    var beforeTitle: String?
    var beforeText: String?
    var beforeButton: String?
    var info: String?
    var answers: Array<Any>?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, order: Int, name: String, image: String, question: String, beforeImage: String, beforeTitle: String, beforeText: String, beforeButton: String, info: String, answers: Array<Any>) {
        
        self.id             = id
        self.order          = order
        self.name           = name
        self.image          = image
        self.question       = question
        self.beforeImage    = beforeImage
        self.beforeTitle    = beforeTitle
        self.beforeText     = beforeText
        self.beforeButton   = beforeButton
        self.info           = info
        self.answers        = answers
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), Order: \(String(describing: order)), Name: \(String(describing: name)),  Image: \(String(describing: image)), Question: \(String(describing: question)), Before Image: \(String(describing: beforeImage)), Before Title: \(String(describing: beforeTitle)), Before Text: \(String(describing: beforeText)), Before Button: \(String(describing: beforeButton)), Info: \(String(describing: info)), Answers: \(String(describing: answers))"
        
    }
    
    
}
