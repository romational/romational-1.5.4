//
//  RomtypeModel.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 2/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol RomtypeDelegate : class {
    
    func goToNextQuestion(_ rtq: String)
}


class RomtypeModel {
    weak var delegate : RomtypeDelegate?
    var page: Int = 0
    
    func updateRomtypeView (rtq: Int) {
        let data = "romtype is \(rtq)"
        page = rtq
        delegate?.goToNextQuestion(data)
        
    }
    
}
