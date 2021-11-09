//
//  SelectivityRankingsViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/28/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class SelectivityRankingsViewController: UIViewController {

 
    // nav links
    
    @IBAction func gotoHome(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoConnect(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Connect") as! ConnectViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoReports(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Reports") as! ReportViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    var slideController : UserOptionsViewController!
    
    @IBAction func showSlideout(_ sender: Any) {
    
        slideController = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as! UserOptionsViewController
           
        let height = self.view.frame.height
        let width = self.view.frame.width
           
        slideController.view.frame = CGRect(x: 0, y: 40, width: 0, height: height)
        slideController.userOptionLogo.isHidden = true
        slideController.closeButton.isHidden = true
        slideController.userButtons.forEach { button in
                button.isHidden = true
            }
        slideController.userIcons.forEach { icon in
                icon.isHidden = true
            }
        slideController.view.isUserInteractionEnabled = true
            
            // animate the display
        UIView.animate(withDuration: 0.6, animations: { self.slideController.view.frame = CGRect(x:0, y:40, width: width, height: height) },
            completion: {(value: Bool) in
            
            self.slideController.closeButton.isHidden = false
            self.slideController.userOptionLogo.isHidden = false
            self.slideController.userButtons.forEach { button in
                    button.isHidden = false
                }
            self.slideController.userIcons.forEach { icon in
                    icon.isHidden = false
                }
           })
            
        self.view.insertSubview(self.slideController.view, at: 30)
            //addChildViewController(controller)
        self.slideController.didMove(toParentViewController: self)
            
        showMenu = true
       
    }
    
      
    // sub nav
    
    @IBAction func reportMenuButton(_ sender: Any) {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           let destination = storyboard.instantiateViewController(withIdentifier: "ReportMenu") as! ReportViewController
           
       destination.modalPresentationStyle = .fullScreen
           self.present(destination, animated: true, completion: nil)
       }
    
    @IBAction func graphButton(_ sender: Any) {
   
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityScore") as! SelectivityViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    @IBAction func breakdownButton(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityAnalysis") as! SelectivityAnalysisViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    // info button
    @IBAction func getInfo(_ sender: Any) {
    
        let pageInfo = VCS["SelectivityRankings"] as! VCSInfoModel
       
        let popupInfo   = pageInfo.popup ?? "n/a"
        let popupTitle  = pageInfo.popupTitle ?? "Score Info"
        let popupButton = pageInfo.popupButton ?? "Ok, Got It"
        
        let alertController:UIAlertController = UIAlertController(title: popupTitle, message: popupInfo, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: popupButton, style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var rankingsTitle: UILabel!
    
    @IBOutlet weak var rankingTable: UIView!
    @IBOutlet weak var rankingsIntroText: UILabel!
    
    @IBAction func switchOrder(_ sender: Any) {
        if factorTableOrder == "normal" {
            factorTableOrder = "reverse"
        }
        else {
            factorTableOrder = "normal"
        }
        // reload
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityRankings") as! SelectivityRankingsViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let pageInfo = VCS["SelectivityRankings"] as? VCSInfoModel
        
        if (pageInfo?.title != nil) {
            //rankingsTitle.text = pageInfo!.title
        }
        if (pageInfo?.info != nil) {
             
            rankingsIntroText.text = pageInfo!.info
        }
        
        // swiping nav
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    // in view functions

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
            
        if (sender.direction == .left) {
           print("Swipe Left")
            //let labelPosition = CGPoint(x: testName.frame.origin.x - 50.0, y: testName.frame.origin.y)
            //testName.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: testName.frame.size.width, height: testName.frame.size.height)
            self.graphButton((Any).self)
            
        }
            
        if (sender.direction == .right) {
            print("Swipe Right")
           // let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
            //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
            self.breakdownButton((Any).self)
        }
    }
    
    

}
