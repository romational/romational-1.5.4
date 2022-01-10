//
//  MyRequestsViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/15/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit



class MyRequestsViewController: UIViewController, MyComparesProtocol, MyRequestsProtocol {

    
    // download compares
    var myComparesList: NSArray = NSArray()
    
    var compareUserId = 0
    
    func myComparesDownloaded(myCompares: NSArray) {
        myComparesList = myCompares
        
        var compCt = 0
        
        myComparesList.forEach { req in
            let thisCompare = req as! MyComparesModel
            /*
            if thisCompare.introStatusMe == "new" {
                compCt = compCt + 1
            }
            else if thisCompare.level1StatusMe == "new" {
                compCt = compCt + 1
            }
            else if thisCompare.level2StatusMe == "new" {
                compCt = compCt + 1
            }
            else if thisCompare.level3StatusMe == "new" {
                compCt = compCt + 1
            }
            else {
                
            }*/
            
            if thisCompare.introStatusMe == "undecided"  || thisCompare.introStatusMe == "new" {
                compCt = compCt + 1
            }
            else if (thisCompare.level1StatusMe == "undecided" || thisCompare.level1StatusMe == "new") && (thisCompare.introStatusThem != "undecided" && thisCompare.introStatusThem != "new" ) {
                compCt = compCt + 1
            }
            else if (thisCompare.level2StatusMe == "undecided" || thisCompare.level2StatusMe == "new") && (thisCompare.level1StatusThem != "undecided" && thisCompare.level1StatusThem != "new" ) && (thisCompare.introStatusThem != "undecided" && thisCompare.introStatusThem != "new" ) {
                compCt = compCt + 1
            }
            else if (thisCompare.level3StatusMe == "undecided" || thisCompare.level3StatusMe == "new")  && (thisCompare.level2StatusThem != "undecided" && thisCompare.level2StatusThem != "new" ) && (thisCompare.level1StatusThem != "undecided" && thisCompare.level1StatusThem != "new") && (thisCompare.level2StatusThem != "undecided" && thisCompare.level2StatusThem != "new" )
            {
                compCt = compCt + 1
            }
            else {
                
            }
            
            
        }
        
        newComps.text = ("\(compCt)")
        
        if compCt > 0 {
            newComps.isHidden = false
            newComps.layer.cornerRadius = 10
        }
       
        
    }
    
    @IBOutlet weak var newComps: UILabel!
    
    
    // download requests
    var myRequestsList: NSArray = NSArray()
    
    func myRequestsDownloaded(myRequests: NSArray) {
        myRequestsList = myRequests
        
        
        var y  = navBar.frame.origin.y + 150
        let x  =  navBar.frame.origin.x

        let vcWidth   = view.bounds.width
        let vcHeight = view.bounds.height
        
        myRequestsList.forEach { req in
            let thisCompare = req as! MyRequestsModel
            
            compareUserId = thisCompare.compareUserId!
            
            if thisCompare.introStatusMe == "undecided" {
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Intro Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoIntroCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                
                y = y + 70
                
            }
            else if  thisCompare.level1StatusMe == "undecided" && thisCompare.introStatusThem != "undecided" {
                
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Level 1 Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoRomtypeCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
    
                
                y = y + 70
            }
            
            else if  thisCompare.level2StatusMe == "undecided" && thisCompare.level1StatusThem != "undecided" {
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Level 2 Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
               
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoFactorsCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                
                y = y + 70
                
            }
            
            else if  thisCompare.level3StatusMe == "undecided" && thisCompare.level2StatusThem != "undecided" {
                let newActionNeeded = UIButton(frame: CGRect(x: 10, y: y, width: vcWidth-20, height: 60))
                newActionNeeded.setTitle ( "Action needed on an Level 3 Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoFullCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                y = y + 70
                
            }
        }
        
    }
    
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
        self.slideController.didMove(toParent: self)
            
        showMenu = true
       
    }
    
    
    // view vars
    @IBOutlet weak var navBar: UIView!
    
    
    @IBOutlet weak var myCompareButton: UIButton!
    @IBAction func gotoMyCompares(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyCompares") as! MyComparesViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    
    }
    
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        /*
        myCompareButton.layer.masksToBounds = false
        //myCompareButton.layer.shadowColor = romDarkGray.cgColor
        myCompareButton.layer.shadowOpacity = 0.3
        myCompareButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        myCompareButton.layer.shadowRadius = 4
        myCompareButton.layer.cornerRadius = 20
        */
        
        newComps.isHidden = true
    }
    

    // custom functions
    
    // compare links
    @objc func gotoIntroCompare(sender: UIButton){
        let compareUserId = sender.tag
        
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareIntro") as! CompareIntroViewController
        
        destination.compareUserId = String(compareUserId)
        destination.qrcodeString = "https://www.romational.com?userId=\(compareUserId)"
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @objc func gotoRomtypeCompare(sender: UIButton){
        let compareUserId = sender.tag
        
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
        
        destination.compareUserId = String(compareUserId)
        destination.qrcodeString = "https://www.romational.com?userId=\(compareUserId)"
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @objc func gotoFactorsCompare(sender: UIButton){
        let compareUserId = sender.tag
    
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @objc func gotoFullCompare(sender: UIButton){
        let compareUserId = sender.tag
    
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL3") as! CompareLevelThreeViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
}

