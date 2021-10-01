//
//  MyDemosModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation



class MyDemosModel: NSObject {
    
    //properties
    var nickName: String?
    var nameFirst : String?
    var nameLast : String?
    var userImage: String?
    var bday: String?
    var location: String?

    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(nickName: String, nameFirst: String, nameLast: String, userImage: String, bday: String, location: String) {
        
        self.nickName       = nickName
        self.nameFirst      = nameFirst
        self.nameLast       = nameLast
        self.userImage      = userImage
        self.bday           = bday
        self.location       = location

        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Nick name: \(nickName), First Name: \(nameFirst), Last Name: \(nameLast), User Image: \(userImage), Birthday: \(bday), Location: \(String(describing: location))"
        
    }
    
    
}
