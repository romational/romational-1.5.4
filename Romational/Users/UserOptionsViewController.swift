//
//  UserOptionsViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/17/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class UserOptionsViewController: UIViewController {

    @IBAction func unwindToUserOptionViewController(_ sender: UIStoryboardSegue) {
    }
    
   
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeSlideout(_ sender: Any) {
        //self.view.removeFromSuperview()
        showMenu = false
        
        // hide elements
        userOptionLogo.isHidden = true
        closeButton.isHidden = true
        userIcons.forEach { icons in
            icons.isHidden = true
        }
        userButtons.forEach { buttons in
            buttons.isHidden = true
        }
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        // animate slide back
        UIView.animate(withDuration: 0.6, animations: { self.view.frame = CGRect(x:0, y:40, width: 0, height: height) },
        completion: {(value: Bool) in
            self.view.removeFromSuperview()
            })
        
        //self.removeFromParentViewController()
    }
    
    @IBAction func gotoHome(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoRTQIntro(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "RTQIntro") as! RTQIntroViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoFQIntro(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "FQIntro") as! FQIntroViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoReports(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Reports") as! ReportViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoCompare(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Connect") as! ConnectViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoProfile(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoAccount(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "UserAccount") as! UserAccountViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    

    @IBAction func gotoAbout(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "AboutRomational") as! AboutRomationalViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    
    @IBAction func gotoMethodology (_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Methodology") as! MethodologyViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func signout (_ sender: Any) {
        
        userId = ""
        
        var profileStarted          = ""
        var prescreenStarted        = ""
        var prescreenCompleted      = ""
        var romtypeStarted          = ""
        var romtypeCompleted        = ""
        var flexibilityStarted      = ""
        var flexibilityCompleted    = ""
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    
    }
    
    
    @IBOutlet weak var userOptionLogo: UIImageView!
    
    // icon images
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var myProfileIcon: UIImageView!
    @IBOutlet weak var myAccountIcon: UIImageView!
    @IBOutlet weak var aboutIcon: UIImageView!
    @IBOutlet weak var methodsIcon: UIImageView!
    @IBOutlet weak var signOutIcon: UIImageView!
    @IBOutlet weak var myReportsIcon: UIImageView!
    @IBOutlet weak var connectIcon: UIImageView!
    
    var userIcons = [UIImageView]()
    
    
    @IBOutlet weak var homeButton: UIButton!

    // buttons
    @IBOutlet weak var romTypeButton: UIButton!
    @IBOutlet weak var flexibilityButton: UIButton!
    @IBOutlet weak var myReportsButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    
    @IBOutlet weak var myProfileButton: UIButton!
    @IBOutlet weak var myAccountButton: UIButton!
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var methodsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var userButtons = [UIButton]()
    
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userOptionLogo.image = UIImage(named: "romational-logo-v4.png")
        
        userButtons.append(homeButton)
        
        userButtons.append(romTypeButton)
        userButtons.append(flexibilityButton)
        userButtons.append(myReportsButton)
        userButtons.append(connectButton)
        
        userButtons.append(myProfileButton)
        userButtons.append(myAccountButton)
        userButtons.append(aboutButton)
        //userButtons.append(methodsButton)
        userButtons.append(logoutButton)
        
        userIcons.append(homeIcon)
        userIcons.append(myProfileIcon)
        userIcons.append(myAccountIcon)
        //userIcons.append(methodsIcon)
        userIcons.append(aboutIcon)
        userIcons.append(signOutIcon)
        userIcons.append(myReportsIcon)
        userIcons.append(connectIcon)
        
        homeIcon.image = UIImage(named: "menu-home-white.png")
        myProfileIcon.image = UIImage(named: "menu-user-white.png")
        myAccountIcon.image = UIImage(named: "menu-account-white.png")
        aboutIcon.image = UIImage(named: "menu-book-white.png")
        //methodsIcon.image = UIImage(named: "menu-bookshelf-white.png")
        signOutIcon.image = UIImage(named: "menu-signout-white.png")
        myReportsIcon.image = UIImage(named: "headNav60-pie-chart.png")
        connectIcon.image = UIImage(named: "headNav60-qcode.png")
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
