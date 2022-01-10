//
//  MyComparesViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 6/29/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit



class MyComparesViewController: UIViewController, MyComparesProtocol, MyRequestsProtocol {

    // info
    
    // download compares
    var myComparesList: NSArray = NSArray()
    
    var compareUserId = 0
    
    func myComparesDownloaded(myCompares: NSArray) {
        myComparesList = myCompares
        
        var y  = navBar.frame.origin.y + 150
        let x  =  navBar.frame.origin.x

        let vcWidth   = view.bounds.width
        let vcHeight = view.bounds.height
        
        /*
        myComparesList.forEach { req in
            let thisCompare = req as! MyComparesModel
            
            compareUserId = thisCompare.userId!
            
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
         */
       
        
    }
    
    
    // download requests
    var myRequestsList: NSArray = NSArray()
    
    func myRequestsDownloaded(myRequests: NSArray) {
        myRequestsList = myRequests
        
        var reqCt = 0
        
        myRequestsList.forEach { req in
            let thisReq = req as! MyRequestsModel
            if thisReq.introStatusMe == "undecided"  || thisReq.introStatusMe == "new" {
                reqCt = reqCt + 1
            }
            else if (thisReq.level1StatusMe == "undecided" || thisReq.level1StatusMe == "new") && (thisReq.introStatusThem != "undecided" && thisReq.introStatusThem != "new" ) {
                reqCt = reqCt + 1
            }
            else if (thisReq.level2StatusMe == "undecided" || thisReq.level2StatusMe == "new") && (thisReq.level1StatusThem != "undecided" && thisReq.level1StatusThem != "new" ) && (thisReq.introStatusThem != "undecided" && thisReq.introStatusThem != "new" ) {
                reqCt = reqCt + 1
            }
            else if (thisReq.level3StatusMe == "undecided" || thisReq.level3StatusMe == "new")  && (thisReq.level2StatusThem != "undecided" && thisReq.level2StatusThem != "new" ) && (thisReq.level1StatusThem != "undecided" && thisReq.level1StatusThem != "new") && (thisReq.level2StatusThem != "undecided" && thisReq.level2StatusThem != "new" )
            {
                reqCt = reqCt + 1
            }
            else {
                
            }
        }
        
        newReqs.text = ("\(reqCt)")
        
        if reqCt > 0 {
            newReqs.isHidden = false
            newReqs.layer.cornerRadius = 10
            newReqs.layer.masksToBounds = true
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
    
    
    @IBOutlet weak var newReqs: UILabel!
    @IBOutlet weak var myRequestsButton: UIButton!
    
    @IBAction func gotoMyRequests(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyRequests") as! MyRequestsViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
       
        
    }
    
    
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        newReqs.isHidden = true
        
        // my compares
        let getMyCompares = MyCompares()
        getMyCompares.delegate = self
        getMyCompares.downloadMyCompares()
      
        // my requests
        let getMyRequests = MyRequests()
        getMyRequests.delegate = self
        getMyRequests.downloadMyRequests()
        
        /*
        myRequestsButton.layer.masksToBounds = false
        //myRequestsButton.layer.shadowColor = romDarkGray.cgColor
        myRequestsButton.layer.shadowOpacity = 0.3
        myRequestsButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        myRequestsButton.layer.shadowRadius = 4
    
        myRequestsButton.layer.cornerRadius = 20
        */
    }
    

    // do after load
    override func viewDidAppear(_ animated: Bool) {
        
        newReqs.layer.cornerRadius = 10
        
    }
    
    
    // custom functions
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

            let cgimage = image.cgImage!
            let contextImage: UIImage = UIImage(cgImage: cgimage)
            let contextSize: CGSize = contextImage.size
            var posX: CGFloat = 0.0
            var posY: CGFloat = 0.0
            var cgwidth: CGFloat = CGFloat(width)
            var cgheight: CGFloat = CGFloat(height)

            // See what size is longer and create the center off of that
            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }

            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

            // Create bitmap image from context using the rect
            let imageRef: CGImage = cgimage.cropping(to: rect)!

            // Create a new image based on the imageRef and rotate back to the original orientation
            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

            return image
        }
    
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
