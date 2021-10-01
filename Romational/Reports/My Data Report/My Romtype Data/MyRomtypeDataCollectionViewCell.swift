//
//  MyRomtypeDataCollectionViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 5/6/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit





class MyRomtypeDataCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var rtqText: UILabel!
    @IBOutlet var rtqAnswer: UILabel!
    
    @IBOutlet weak var rtqImage: UIImageView!
    
    
    func printRTQCells(order: Int, question: String, answer: String, image: String) {
        
        self.rtqText.text = ("#\(order) \(question)").uppercased()
        self.rtqAnswer.text = ("\(answer)")
        
        //self.rtqImage.image = UIImage(named: image)
        
      
    }
    
    
}
