//
//  RomtypeListModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class MyRomtypeAnswersModel: NSObject {
    
    //properties
    
    var questionId: String?
    var answerId: String?
    
    //empty constructor
    
    override init() {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(questionId: String, answer: String) {
        
        self.questionId = questionId
        self.answerId = answer
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "QuestionID: \(String(describing: questionId)) Answer: \(String(describing: answerId))"
        
    }
    
    
}
