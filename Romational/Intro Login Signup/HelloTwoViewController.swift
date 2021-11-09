//
//  HelloTwoViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 6/25/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit


class HelloTwoViewController: UIViewController {

    
    
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
    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var helloMessage: GradientLabel!
    @IBOutlet weak var thankYou: UILabel!
    
    
    @IBOutlet weak var setupBkgd: UIButton!
    @IBOutlet weak var setupButton: UIButton!
    
    @IBAction func setupProfile(_ sender: Any) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
    }
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // navbar bkgd image colorbar
        let bkgdImage = UIImageView(frame: CGRect(x: 0, y: self.navBar.frame.origin.y+20, width: self.view.bounds.size.width, height: 60))
        bkgdImage.image = UIImage(named: "Header-2000x250.png.png")
        view.addSubview(bkgdImage)
        view.sendSubview(toBack: bkgdImage)
        
        
        let pageInfo = VCS["Hello"] as? VCSInfoModel
        
         if (pageInfo?.title != nil) {
            helloMessage.text = pageInfo!.title
         }
         if (pageInfo?.info != nil) {
             
            thankYou.text = pageInfo!.info
         }
        
        helloMessage.gradientColors = [romTeal.cgColor, romOrange.cgColor, romPink.cgColor]
        
        setupBkgd.layer.borderColor = white.cgColor
        setupBkgd.layer.borderWidth = 4
        setupBkgd.layer.cornerRadius = 30
        
        setupBkgd.layer.masksToBounds = false
        setupBkgd.layer.shadowColor = white.cgColor
        setupBkgd.layer.shadowOpacity = 0.80
        setupBkgd.layer.shadowOffset = CGSize(width: -4, height: -4)
        setupBkgd.layer.shadowRadius = 4
        
        setupButton.layer.masksToBounds = false
        setupButton.layer.shadowColor = romDarkGray.cgColor
        setupButton.layer.shadowOpacity = 0.3
        setupButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setupButton.layer.shadowRadius = 4
        setupButton.layer.borderColor = palegray.cgColor
        setupButton.layer.borderWidth = 2
        setupButton.layer.cornerRadius = 30
        
        // Do any additional setup after loading the view.
    }
    


}

