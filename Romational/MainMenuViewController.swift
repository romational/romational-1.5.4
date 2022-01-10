//
//  ViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 11/7/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UserLogsProtocol {
    
    var userLog : NSArray = NSArray()
    
    func UserLogsDownloaded(userLogs: NSArray) {
        
        userLog = userLogs
        
        //print ("profile started? \(profileStarted)")
        
  
        // user logs
        if (profileStarted == "") {
            print ("no profile started should be sent to hello")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "Hello") as! HelloTwoViewController
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false)
        }
        
    }
    

    // nav links
    
    @IBAction func gotoProfile(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    
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
    
        slideController = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as? UserOptionsViewController
           
            
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
    
    
    
    
    // view variables
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var introText: UILabel!
        
    @IBOutlet weak var getRomtypeView: UIView!
    
    
    @IBOutlet weak var navBar: UIView!
    
    var buttons = [UIButton]()
    
    @IBOutlet weak var getRomtypeButton: UIButton!
    @IBOutlet weak var getSelectivityButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    
    //@IBOutlet weak var connectButton: UIButton!
    
    @IBAction func assessBtn(_ sender: Any) {
        getRomtypeButton.layer.backgroundColor = romLightGray.cgColor
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RTQIntro") as! RTQIntroViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @IBAction func flexibilityBtn(_ sender: Any) {
        getSelectivityButton.layer.backgroundColor = romLightGray.cgColor
    }
    @IBAction func reportsBtn(_ sender: Any) {
        reportsButton.layer.backgroundColor = romLightGray.cgColor
    }
    
    @IBAction func connectBtn(_ sender: Any) {
        connectButton.layer.backgroundColor = romLightGray.cgColor
    }
    
    @IBOutlet weak var newConnects: UILabel!
    
    var btnBkgds = [UIView]()
    var bkgds = [UIView]()
    
    @IBOutlet weak var btnBkgd: UIView!
    @IBOutlet weak var btnBkgd2: UIView!
    @IBOutlet weak var btnBkgd3: UIView!
    
    @IBOutlet weak var btnBkgd4: UIView!
   
    
    // load view
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        /*let bkgdImage = UIImageView(frame: CGRect(x: 0, y: self.navBar.frame.origin.y , width: self.view.bounds.size.width, height: 60))
        bkgdImage.image = UIImage(named: "Header-2000x250.png.png")
        view.addSubview(bkgdImage)
        view.sendSubview(toBack: bkgdImage)
        */
        
        logoImage.image  = UIImage(named:"romational-logo-v4.png")

        let pageInfo = VCS["MainMenu"] as? VCSInfoModel
        
       
        if (pageInfo?.info != nil) {
            introText.text = pageInfo!.info
            introText.textColor = romDarkGray
        }
        
        let getUserLogs = UserLogs()
        getUserLogs.delegate = self
        getUserLogs.downloadUserLogs()
        
        newConnects.isHidden = true
        newConnects.layer.cornerRadius = 10
        newConnects.layer.masksToBounds = true
        
        // morphs array
        btnBkgds.append(btnBkgd)
        btnBkgds.append(btnBkgd2)
        btnBkgds.append(btnBkgd3)
        btnBkgds.append(btnBkgd4)
        
        btnBkgds.forEach { btn in
            //btn.addInnerShadowToView(color: white, offsetX: -6, offsetY: -6, shadowSize: 4)
            //btn.addInnerShadowToView(color: romDarkGray, offsetX: 3, offsetY: 3, shadowSize: 9)
            
            //btn.addBkgdShadowToView(color: yellow, offsetX: -4, offsetY: -4, opacity: 80, shadowSize: 4)
            btn.layer.masksToBounds = false
            btn.layer.shadowColor = white.cgColor
            btn.layer.shadowOpacity = 0.8
            btn.layer.shadowOffset = CGSize(width: -4, height: -4)
            btn.layer.shadowRadius = 4
            
            btn.layer.borderColor = palegray.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 30
            
        }
        
                
        // button array
        buttons.append(getRomtypeButton)
        buttons.append(getSelectivityButton)
        buttons.append(reportsButton)
        buttons.append(connectButton)
        
        // add button styling
        buttons.forEach { button in
            
            //button.addBkgdShadowToButton(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 30, shadowSize: 4)
            button.layer.masksToBounds = false
            button.layer.shadowColor = romDarkGray.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
        
            button.layer.cornerRadius = 30
        
        }
        
    }

    // do after load
    override func viewDidAppear(_ animated: Bool) {
        
        checkNewCompares()
     
    }
    
    
    func checkNewCompares() {
        
        postWithCompletion(parameters: [userId], urlString: "https://romdat.com/compares/\(userId)/new") { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                //print ("new compares")
                self.newConnects.isHidden = false
                self.newConnects.text = String(result["count"] as! Int)
                self.newConnects.layer.cornerRadius = 10
            }
            
        }
        
    }

}

