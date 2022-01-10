//
//  FactorAnswerTableViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/23/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class FactorAnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var factorRank: UILabel!
    @IBOutlet weak var factorImage: UIImageView!
    @IBOutlet weak var factorName: UILabel!
    @IBOutlet weak var factorRange: UILabel!
    
    func displayFactorAnswers (fqid: Int, rank: Int, factor: String, image: String, selectivity: String) {
        
        let thisSelectivity = Double(selectivity)!
        let printSelectivity = Int(thisSelectivity * 100)
        
        self.factorImage.image = UIImage(named: image)
        
        self.factorRank.text = ("#\(rank)")
        self.factorName.text = ("\(factor)")
        self.factorRange.text = ("\(printSelectivity)")
        
        //print ("ranges here")
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
            let rangeName = thisRange!["name"] as? String
            let lowRange  = Double((thisRange!["low"] as? String)!)! / 100.0
            let highRange = Double((thisRange!["high"] as? String)!)! / 100.0
            
            //print ("selectivity is \(thisSelectivity) low \(lowRange) high \(highRange)")
            
            // fix bullshit 0 changed to 50 bkgd error
         
            if ((thisSelectivity > lowRange)) && (thisSelectivity <= highRange) {
                if i == 0 {
                    self.factorRange.textColor = white
                    self.factorRange.backgroundColor = romTeal
                }
                if i == 1 {
                    self.factorRange.textColor = white
                    self.factorRange.backgroundColor = green
                }
                if i == 2 {
                    self.factorRange.textColor = white
                    self.factorRange.backgroundColor = yellow
                }
                if i == 3 {
                    self.factorRange.textColor = white
                    self.factorRange.backgroundColor = romOrange
                }
                if i == 4 {
                    self.factorRange.textColor = white
                    self.factorRange.backgroundColor = romPink
                }
            }
            else if (thisSelectivity == 0){
                self.factorRange.textColor = white
                self.factorRange.backgroundColor = romTeal
            }
        }
                
            /*
        if (thisSelectivity <= 0.20) {
            self.factorRange.textColor = black
            self.factorRange.backgroundColor = yellow
        }
        if (thisSelectivity > 0.20) && (thisSelectivity <= 0.40) {
            self.factorRange.textColor = black
            self.factorRange.backgroundColor = green
        }
        if (thisSelectivity > 0.40) && (thisSelectivity <= 0.60)  {
            self.factorRange.textColor = black
            self.factorRange.backgroundColor = teal
        }
        if (thisSelectivity > 0.60) && (thisSelectivity <= 0.80)  {
            self.factorRange.textColor = white
            self.factorRange.backgroundColor = navy
        }
        if (thisSelectivity > 0.80) {
            self.factorRange.textColor = white
            self.factorRange.backgroundColor = purple
        }
 */
        //print (status)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
