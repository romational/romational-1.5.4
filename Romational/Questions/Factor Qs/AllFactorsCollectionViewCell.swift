//
//  AllFactorsCollectionViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/30/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import Foundation
import UIKit

class AllFactorsCollectionViewCell: UICollectionViewCell {
 
    
    @IBOutlet weak var factorView: UIView!
    @IBOutlet weak var factorImage: UIImageView!
    
    @IBOutlet weak var factorIcon: UIImageView!
    @IBOutlet weak var factorLabel: UILabel!
    
    func displayFactorIcons (fq: Int, factor: String, image: String, status: String) {
        
        //print (image)
        // add done to image name
        if (status == "done") {
            //print (status)
            let grayImage = image.replacingOccurrences(of: ".png", with: "-pressed.png")
            self.factorImage.image = UIImage(named: grayImage)
            //self.factorIcon.image = UIImage(named: icon)
        }
        else {
            self.factorImage.image = UIImage(named: image)
            
            //let grayIcon = icon.replacingOccurrences(of: ".png", with: "-gray.png")
            //self.factorIcon.image = UIImage(named: grayIcon)
        }
        
        
        self.factorLabel.text = ("\(factor)")
        //print (status)
        
    }
    
    
}
