//
//  RomtypeInfoViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/21/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class RomtypeInfoViewController: UIViewController, RomtypeInfoProtocol, RomtypeListProtocol  {
    
    // global view vars
    var romtypeList = NSArray()
    var romtypeArrayId = 0
    var nextRomtype = 0
    var prevRomtype = 0
    
    var romLink = ""
    
    @IBOutlet weak var learnMoreButton: UIButton!
    
    @IBAction func gotoURL(_ sender: Any) {
    
        UIApplication.shared.open(URL(string: romLink)!)
    }
    
    // downloads
    func infoDownloaded(info: NSDictionary) {
        romTypeInfo = info
        print (romTypeInfo)
        
        titleBar.text = ("About \(romTypeInfo["romtype_name"] as! String)").uppercased()
        romtypeName.text = (romTypeInfo["romtype_name"] as! String).uppercased()
        let romImage = romTypeInfo["romtype_image"] as! String
        
        romLink = romTypeInfo["romtype_url"] as! String
        
        romtypeImage.image = UIImage(named: romImage)
        
        romtypeDefinition.text = romTypeInfo["romtype_define"] as! String
        romtypeInfo.text = romTypeInfo["romtype_info"] as! String
        
    }
    
    func romtypesDownloaded(romtypes: NSArray) {
        romtypeList = romtypes
        
        romtypeList.forEach { romtype in
            let thisRomtype = romtype as! RomtypeListModel
            
            if viewRomTypeName == thisRomtype.code! {
                romtypeArrayId = thisRomtype.id! - 1
            }
       
        }
        //print (romtypeArrayId)
        nextRomtype = romtypeArrayId + 1
        prevRomtype = romtypeArrayId - 1
        
        if nextRomtype > 5 {
            nextRomtype = 0
        }
        if prevRomtype < 0 {
            prevRomtype = 5
        }
        //print (nextRomtype)
        //print (prevRomtype)
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
    
    
    // return to My Romtype
    @IBAction func backToMyRomType(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeReport") as! RomtypeReportViewController
        
         destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    
    @IBAction func showNext(_ sender: Any) {
    
        let thisRomtype = romtypeList[nextRomtype] as! RomtypeListModel
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "RomtypeInfo") as! RomtypeInfoViewController
        
        secondViewController.viewRomTypeName = thisRomtype.code!
        print (thisRomtype.code!)
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: false)
    }
    
    
    @IBAction func showPrev(_ sender: Any) {
    
        let thisRomtype = romtypeList[prevRomtype] as! RomtypeListModel
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "RomtypeInfo") as! RomtypeInfoViewController
     
        secondViewController.viewRomTypeName = thisRomtype.code!
        print (thisRomtype.code!)
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: false)
    }
    
    
    
    // view vars
    
    @IBOutlet weak var thisScrollView: UIScrollView!
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var titleBar: UILabel!
    
    var romTypeInfo: NSDictionary = NSDictionary()
    
    @IBOutlet weak var romtypeImage: UIImageView!
    @IBOutlet weak var romtypeName: UILabel!
    @IBOutlet weak var romtypeDefinition: UITextView!
    @IBOutlet weak var romtypeInfo: UITextView!

    var viewRomTypeImage: UIImage = UIImage()
    var viewRomTypeName: String = String()

   
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

   
        let allRomtypeInfo = RomtypeInfo()
        allRomtypeInfo.delegate = self
        allRomtypeInfo.downloadInfo(romtype: viewRomTypeName)
       
        let romImage = viewRomTypeName + "-heart"
             
        let getRomtypes = RomtypeList()
        getRomtypes.delegate = self
        getRomtypes.downloadRomtypes()
       
        
        learnMoreButton.layer.masksToBounds = false
        learnMoreButton.layer.shadowColor = romDarkGray.cgColor
        learnMoreButton.layer.shadowOpacity = 0.3
        learnMoreButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        learnMoreButton.layer.shadowRadius = 4
        learnMoreButton.layer.cornerRadius = 20
        
    }

    override func viewWillLayoutSubviews() {
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
