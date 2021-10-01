//
//  AllRomtypesCollectionViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/30/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import Foundation
import UIKit

class AllRomtypesCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var romtypeImage: UIImageView!
    
    @IBOutlet weak var romtypeLabel: UILabel!
    
    func displayRomtypeIcons (fq: Int, romtype: String, image: String, status: String) {
        
        //print (image)
        
        // add done to image name
        if (status == "done") {
            
            let grayImage = image.replacingOccurrences(of: ".png", with: "-pressed.png")
            self.romtypeImage.image = UIImage(named: grayImage)
       
        }
        else {
        
            self.romtypeImage.image = UIImage(named: image)
        
        }
        
        
        
        self.romtypeLabel.text = ("\(romtype)")
        //print (status)
        
    }
    
    var context = CIContext(options: nil)
   
    
}
