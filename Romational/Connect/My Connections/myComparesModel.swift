//
//  myComparesModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/8/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation


class MyComparesModel: NSObject {
    
    //properties
    
    var id: Int?
    var userId: Int?
    var compareUserId: Int?
    var nickName: String?
    var firstName: String?
    var lastName: String?
    var image: String?
    var info: String?
    var introStatusMe: String?
    var level1StatusMe: String?
    var level2StatusMe: String?
    var level3StatusMe: String?
    var level4StatusMe: String?
    var introStatusThem: String?
    var level1StatusThem: String?
    var level2StatusThem: String?
    var level3StatusThem: String?
    var level4StatusThem: String?
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, userId: Int, nickName: String, firstName: String, lastName: String, image: String, info: String, IntroStatusMe: String, level1StatusMe: String, level2StatusMe: String, level3StatusMe: String,  level4StatusMe: String, introStatusThem: String, level1StatusThem: String, level2StatusThem: String, level3StatusThem: String,  level4StatusThem: String) {
        
        self.id             = id
        self.userId         = userId
        self.nickName       = nickName
        self.firstName      = firstName
        self.lastName       = lastName
        self.image          = image
        self.info           = info
        
        self.introStatusMe    = introStatusThem
        self.level1StatusMe   = level1StatusMe
        self.level2StatusMe   = level2StatusMe
        self.level3StatusMe   = level3StatusMe
        self.level4StatusMe   = level4StatusMe
        
        self.introStatusThem  = introStatusThem
        self.level1StatusThem   = level1StatusThem
        self.level2StatusThem   = level2StatusThem
        self.level3StatusThem   = level3StatusThem
        self.level4StatusThem   = level4StatusThem
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(String(describing: id)), User ID: \(String(describing: userId)) - Name: \(String(describing: nickName)), First Name: \(String(describing: firstName)), Last Name: \(String(describing: lastName)), Image: \(String(describing: image)), Info: \(String(describing: info)), Intro Status Me: \(String(describing: introStatusMe)), Level 1 Me: \(String(describing: level1StatusMe)), Level 2 Me: \(String(describing: level2StatusMe)), Level 3 Me: \(String(describing: level3StatusMe)), Level 4 Me: \(String(describing: level4StatusMe)), IntroStatus Them: \(String(describing: introStatusThem)), Level 1 Them: \(String(describing: level1StatusThem)), Level 2 Them: \(String(describing: level2StatusThem)), Level 3 Them: \(String(describing: level3StatusThem)), Level 4 Them: \(String(describing: level4StatusThem))"
        
    }
    
    
}
