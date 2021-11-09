//
//  MyQRCodeViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/6/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class MyQRCodeViewController: UIViewController, MyDemosProtocol {

    // user info (demos)
    
    var myDemoInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        
        myDemoInfo = demoInfo
        //print (myDemoInfo)
        
        if (myDemoInfo.count > 0) {
            let profile = (myDemoInfo[0] as? MyDemosModel)!
            
            //print (profile)
            // name config
            if (profile.nickName! != "" ) {
                //userName.text = profile.nickName
            }
            else {
                //userName.text = ("\(profile.nameFirst!) \(profile.nameLast!)")
            }
            
            /*
            // async download
            let urlString = "http://romadmin.com/images/users/\(profile.userImage!)"
            print (urlString)
            if let url = URL(string: urlString) {
     
                downloadImage(from: url)
            }
            */
            
       
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
        self.slideController.didMove(toParentViewController: self)
            
        showMenu = true
       
    }
    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var qrcodeImage: UIImageView!
    
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()


        qrcodeImage.image = generateQRCode(from: "http://romational.com?userId=\(userId)")
        
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: userId)
        
        
     
        
    }
    
    
    // view functions
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }


}
