//
//  CompareIntroViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/15/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class CompareIntroViewController: UIViewController, MyDemosProtocol {

    // user profile demo info
    
    var myDemoInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        
        myDemoInfo = demoInfo
        //print (myDemoInfo)
        
        if (myDemoInfo.count > 0) {
            let profile = (myDemoInfo[0] as? MyDemosModel)!
            
            print (profile)
            // name config
            if  (profile.nickName! != "") {
                compareName.text = profile.nickName!
            }
            else {
                compareName.text = ("\(profile.nameFirst!) \(profile.nameLast!)")
            }
            
            // async download
            let urlString = "http://romadmin.com/images/users/\(profile.userImage!)"
            //print (urlString)
            if let url = URL(string: urlString) {
     
                downloadImage(from: url)
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
        self.slideController.didMove(toParentViewController: self)
            
        showMenu = true
       
    }
    
    
    // level navs
    
    
    @IBOutlet weak var introButton: UIButton!
    
    @IBAction func gotoCompareIntro(_ sender: Any) {
       
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareIntro") as! CompareIntroViewController
        
        destination.compareUserId = compareUserId
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    
    }
    
    @IBAction func gotoLevelOne(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
        
        destination.compareUserId = compareUserId
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @IBAction func gotoLevelTwo(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
        
        destination.compareUserId = compareUserId
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @IBAction func gotoLevelThree(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL3") as! CompareLevelThreeViewController
        
        destination.compareUserId = compareUserId
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @IBAction func gotoCompareShare(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareShareInfo") as! CompareShareInfoViewController
        
        destination.compareUserId = compareUserId
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    
    // view vars
    
    
    @IBOutlet weak var navBar: UIView!
    
   
    @IBOutlet weak var compareResult: GradientLabel!
    @IBOutlet weak var compareImage: UIImageView!
    @IBOutlet weak var compareName: UILabel!
    

    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var compareUserId = ""
    var qrcodeString = ""
    
    var buttons = [UIButton]()
    
    // button actions
    @IBAction func endConnection(_ sender: Any) {
    
        updateCompareUser(compareUserId: compareUserId, compareStatus: "denied")
        
    }
    
    @IBAction func doContinue(_ sender: Any) {
        
        print ("hey ok continue")
        updateCompareUser(compareUserId: compareUserId, compareStatus: "approved")
    
    }
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        introButton.underline()
        print (qrcodeString)
        
        if qrcodeString != "" {
            let compareURL = URL(string: qrcodeString)!
            compareUserId = compareURL.valueOf("userId")!
        }
        
        print (compareUserId)
        
        addCompareUser(compareUserId: compareUserId)
        
        // my info
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: compareUserId)
        
        
        buttons.append(endButton)
        buttons.append(continueButton)
        
        buttons.forEach { btn in
            
            // button styling
            btn.isUserInteractionEnabled = true
            btn.layer.masksToBounds = false
            btn.layer.shadowColor = romDarkGray.cgColor
            btn.layer.shadowOpacity = 0.3
            btn.layer.shadowOffset = CGSize(width: 4, height: 4)
            btn.layer.shadowRadius = 4
            btn.layer.borderColor = palegray.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 30
            
        }
        
        //compareResult.gradientColors = [romTeal.cgColor, romOrange.cgColor, romPink.cgColor]
        
    }
    
    // view functions
    
    func addCompareUser(compareUserId: String) {
        
        let compareType = "intro"
        let compareURLString = "https://romdat.com/compare/add/\(userId)/\(compareUserId)/\(compareType)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: "https://romdat.com/compare/add/\(userId)/\(compareUserId)/\(compareType)") { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                print ("compare basic added")
 
            }
            
        }
        
    }
    
    func updateCompareUser(compareUserId: String, compareStatus: String) {
        
        let compareType = "intro"
        let compareURLString = "https://romdat.com/compare/update/\(userId)/\(compareUserId)/\(compareType)/\(compareStatus)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: "https://romdat.com/compare/update/\(userId)/\(compareUserId)/\(compareType)/\(compareStatus)") { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                if (compareStatus == "approved") {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
                    
                    destination.compareUserId = compareUserId
                    
                    destination.modalPresentationStyle = .fullScreen
                    self.present(destination, animated: false)
                }
                else {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destination = storyboard.instantiateViewController(withIdentifier: "MyCompares") as! MyComparesViewController
                    destination.modalPresentationStyle = .fullScreen
                    self.present(destination, animated: false)
                }
 
            }
           
            if result["success"] as! String == "ok" {
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
                
                destination.compareUserId = compareUserId
                
                destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false)
        
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
                
                self.compareImage.image = UIImage(data: data)
            }
        }
    }
    

}
