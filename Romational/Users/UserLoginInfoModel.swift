//
//  UserLoginInfoModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 6/14/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class UserLoginInfoModel: NSObject {
    
    //properties
    
    var loginEmail:     String?
    var loginPassword:  String?

    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(loginEmail: String, loginPassword: String ) {
        
        self.loginEmail        = loginEmail
        self.loginPassword     = loginPassword
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "login email: \(loginEmail),  login password: \(loginPassword)"
        
    }
    
    
}
