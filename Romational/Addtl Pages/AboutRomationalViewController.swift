//
//  AboutRomationalViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/14/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit
import WebKit

class AboutRomationalViewController: UIViewController {
  
   
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
    
    
    
    
    
    // view vars
    @IBOutlet weak var navBar: UIView!
    
    
    @IBOutlet weak var aboutTitle: UILabel!
    
    @IBOutlet weak var aboutIntro: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    
    @IBAction func gotoWebsite(_ sender: Any) {
        //UIApplication.shared.openURL(URL(string: "http://www.romational.com")!)
        UIApplication.shared.open(URL(string: "http://www.romational.com")!)
    }
    
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        // Do any additional setup after loading the view.
        let pageInfo = VCS["AboutRomational"] as? VCSInfoModel
        
        if (pageInfo?.title != nil) {
            //aboutTitle.text = pageInfo!.title?.uppercased()
        }
        
        if (pageInfo?.info != nil) {
             
            //aboutIntro.text = pageInfo!.info
        }
        
        let myURL = URL(string:"http://www.romational.com")
               let myRequest = URLRequest(url: myURL!)
               webView.load(myRequest)
        
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
