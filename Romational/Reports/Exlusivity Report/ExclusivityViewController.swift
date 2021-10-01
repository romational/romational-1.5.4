//
//  ExclusivityViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/16/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class ExclusivityViewController: UIViewController, ExclusivityProtocol {
    
    var myExclusivity : NSDictionary = NSDictionary()
    
    func exclusivityDownloaded(exclusivity: NSDictionary) {
        
        myExclusivity = exclusivity
        
        print (myExclusivity)
    }
    

    @IBOutlet var exclusivityBkgd: UIView!
    @IBOutlet weak var exclusivityTitle: UILabel!
    
    @IBOutlet weak var exclusivityBar: UIView!
    
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    
    var buttons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exclusivityBkgd.backgroundColor = UIColor(patternImage: UIImage(named: "gray-shade.png")!)
        exclusivityBar.backgroundColor = orange
        
        // load page details
        let pageInfo = VCS["ExclusivityReport"] as? VCSInfoModel
        
         if (pageInfo?.title != nil) {
            exclusivityTitle.text = pageInfo!.title
         }
        /* if (pageInfo?.info != nil) {
             
             reportIntroText.text = pageInfo!.info
         }
        */
        
        // button array
        buttons.append(retakeButton)
        buttons.append(homeButton)
        buttons.append(reportsButton)
        
        // add styling
        buttons.forEach { button in
            
            button.layer.borderWidth = 2
            button.layer.borderColor = black.cgColor
            
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 5, height: 5)
            button.layer.shadowRadius = 5
            button.layer.shadowOpacity = 1.0
            
        }
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
