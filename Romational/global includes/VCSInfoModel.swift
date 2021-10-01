//
//  VCSInfoModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

class VCSInfoModel: NSObject {
    
    //properties
    
    var id: Int?
    var name: String?
    var title: String?
    var popup: String?
    var popupTitle: String?
    var popupButton: String?
    var vcClass: String?
    var storyboardID: String?
    var image: String?
    var info: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @address, @latitude, and @longitude parameters
    
    init(id: Int, name: String, title: String, popup: String, popupTitle: String, popupButton: String, vcClass: String, storyboardID: String, image: String, info: String) {
        
        self.id     = id
        
        self.name           = name
        self.title          = title
        self.popup          = popup
        self.popupTitle     = popupTitle
        self.popupButton    = popupButton
        self.vcClass        = vcClass
        self.storyboardID   = storyboardID
        
        self.image          = image
        self.info           = info
        
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(id),  Name: \(name), Title: \(title), Popup: \(popup), Popup Title: \(popupTitle), Popup Button: \(popupButton), Class: \(vcClass), Storyboard: \(storyboardID), Image: \(String(describing: image)), Info: \(String(describing: info))"
        
    }
    
    
}
