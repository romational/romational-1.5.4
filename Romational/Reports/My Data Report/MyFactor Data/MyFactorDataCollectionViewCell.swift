//
//  FactorReportCollectionViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/3/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

class MyFactorDataCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var factorBkgd: UIView!
    @IBOutlet weak var factorImage: UIImageView!
    @IBOutlet var factorSelectivity: UILabel!
    
    @IBOutlet var factorName: UILabel!
    @IBOutlet var factorAnswer: UILabel!
    
    
    func displayFactorResults (factor: String, order: String, image: String, answer: String, selectivity: Double) {

        self.factorName.text = ("\(order). \(factor)").uppercased()
        self.factorAnswer.text = ("\(answer)")
        
        //self.factorAnswer.sizeThatFits()
        
        let ringImage = ("ring-\(image)")
        self.factorImage.image = UIImage(named: ringImage)
        self.factorImage.tintColor = romLightGray
        
        //self.factorBkgd.image = UIImage(named: "button-bkgd-depressed.png")
        factorAnswer.sizeToFit()
        
        
        //print ("ranges here")
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            
            let rangeName = thisRange!["name"] as? String
            let lowRange  = Double((thisRange!["low"] as? String)!)! / 100.0
            let highRange = Double((thisRange!["high"] as? String)!)! / 100.0
            
            
            
            if (selectivity > lowRange) && (selectivity <= highRange) {
                /*
                self.factorSelectivity.text = rangeName!.uppercased()
                */
                
                //print (factor)
                //print (selectivity)
                //print (lowRange)
                //print (highRange)
                
                if i == 0 {
                    //self.factorBkgd.backgroundColor = romTeal
                    self.factorImage.tintColor = romTeal
                }
                if i == 1 {
                    //self.factorBkgd.backgroundColor = green
                    self.factorImage.tintColor = green
                }
                if i == 2 {
                    //self.factorBkgd.backgroundColor = yellow
                    self.factorImage.tintColor = yellow
                }
                if i == 3 {
                    //self.factorBkgd.backgroundColor = romOrange
                    self.factorImage.tintColor = romOrange
                }
                if i == 4 {
                    //self.factorBkgd.backgroundColor = romPink
                    self.factorImage.tintColor = romPink
                }
                 
            }
        }
   
    }
    
    // this resizes the text containener
    override func layoutSubviews() {
        super.layoutSubviews()
        factorAnswer.sizeToFit()
    }
    
}
