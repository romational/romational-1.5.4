//
//  ShareContactViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/20/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class CompareShareInfoViewController: UIViewController, MyDemosProtocol {

    // load info
    
    // user profile demo info
    
    var myDemoInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        
        myDemoInfo = demoInfo
        print (myDemoInfo)
        
        if (myDemoInfo.count > 0) {
            let profile = (myDemoInfo[0] as? MyDemosModel)!
            
            //print (profile)
            // name config
            
            userNickName.text  = profile.nickName!
            userFirstName.text = profile.nameFirst!
            userLastName.text  = profile.nameLast!
   
            
            // async download
            let urlString = "http://romadmin.com/images/users/\(profile.userImage!)"
            print (urlString)
            if let url = URL(string: urlString) {
     
                downloadImage(from: url)
            }
            
       
        }
        
    }
    
    // nav links
    
    @IBAction func gotoMyCompares(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyCompares") as! MyComparesViewController
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
    @IBOutlet weak var confirmNeeded: UIView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    
    var compareUserId = ""
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        
        // compare user info
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: compareUserId)
        
    }
    
    
    // do after load
    override func viewDidAppear(_ animated: Bool) {
        
        checkApprovals(compareUserId: compareUserId)
        
    }
    
    
    // view functions
    
    func checkApprovals(compareUserId: String) {
        
        let compareType = "level-3"
        let compareURLString = "https://romdat.com/compare/\(userId)/\(compareUserId)/\(compareType)/check"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: compareURLString) { success, result in
            
            print (result)
            
            if result["success"] as! String == "yes" {
                print ("ok show the f'in thing")
                self.confirmNeeded.isHidden = true
            }
            else {
                
                
            }
        
        }
        
    }
    
    
    
    // MARK: image downloading
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print (data)
            print("Download Finished")
            DispatchQueue.main.async() {
                
                self.userImage.image = UIImage(data: data)
            }
        }
    }

}
