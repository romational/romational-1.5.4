//
//  CompareLevelOneViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 6/30/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class CompareLevelOneViewController: UIViewController, MyDemosProtocol, MyRomtypeProtocol, CompareRomtypeProtocol {
   

    
    // user profile demo info
    
    var myDemoInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        
        myDemoInfo = demoInfo
        print (myDemoInfo)
        
        if (myDemoInfo.count > 0) {
            let profile = (myDemoInfo[0] as? MyDemosModel)!
            
            //print (profile)
            // name config
            if (profile.nickName != nil) {
                compareUserName.text = profile.nickName
            }
            else {
                compareUserName.text = ("\(profile.nameFirst!) \(profile.nameLast!)")
            }
            
            // async download
            let urlString = "http://romadmin.com/images/users/\(profile.userImage!)"
            //print (urlString)
            if let url = URL(string: urlString) {
     
                //downloadImage(from: url)
            }
            
       
        }
        
    }
    
    // romtypes
    
    // my romtype info
  
    var myRomtype = NSArray()
    var romtype1 = ""
    
    func myRomtypeDownloaded(myRomtypeInfo: NSArray) {
        
        myRomtype = myRomtypeInfo
        //print (myRomtype)
        if let first = myRomtype[0] as? [String: Any] {
    
            let firstImage  = first["image"] as? String
            let firstName   = first["name"] as? String
            romtype1 = (first["type"] as? String)!
            let firstInfo   = first["info"] as? String
            let firstDefine = first["define"] as? String
            
     
        }
        
        // download romtype info
        let getCompareRomtype = CompareRomtype()
        getCompareRomtype.delegate = self
        getCompareRomtype.downloadCompareRomtype(userid: compareUserId)
    
    }
    
    
    // bring in compare romtype info
    
    var compareRomtype = NSArray()
    var romtype2 = ""
    
    func compareRomtypeDownloaded(compareRomtypeInfo: NSArray) {
        
        compareRomtype = compareRomtypeInfo
        //print (myRomtype)
        if let first = compareRomtype[0] as? [String: Any] {
    
            let firstImage  = first["image"] as? String
            let firstName   = first["name"] as? String
            romtype2 = (first["type"] as? String)!
            let firstInfo   = first["info"] as? String
            let firstDefine = first["define"] as? String
            
        }
        
        compareRomtypes(romtype1: romtype1, romtype2: romtype2)
        
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
  
    @IBOutlet weak var L1Button: UIButton!
    
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
    @IBOutlet weak var confirmNeeded: UIView!
    
    @IBOutlet weak var waitingImage: UIImageView!
    @IBOutlet weak var waitingMessage: UILabel!
    
    
    @IBOutlet weak var compareResult: GradientLabel!
    
    var compareUserId = ""
    
    @IBOutlet weak var compareUserImage: UIImageView!
    @IBOutlet weak var compareUserName: UILabel!
    
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var myComparesButton: UIButton!
    
    var buttons = [UIButton]()
    
    // button actions
    @IBAction func refreshView(_ sender: Any) {
    
        /*
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Connect") as! ConnectViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        */
        
        //self.view.layoutIfNeeded()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
        
        destination.compareUserId = compareUserId
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    
    @IBAction func gotoMyCompares(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyCompares") as! MyComparesViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    var qrcodeString = ""

    
    // button actions
    @IBAction func endConnection(_ sender: Any) {
    
        updateCompareUser(compareUserId: compareUserId, compareStatus: "denied")
        
    }
    
    @IBAction func doContinue(_ sender: Any) {
    
        updateCompareUser(compareUserId: compareUserId, compareStatus: "approved")
        
    }
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        L1Button.underline()
        
        buttons.append(endButton)
        buttons.append(continueButton)
        buttons.append(cancelButton)
        buttons.append(myComparesButton)
        
        buttons.forEach { btn in
            
            // button styling
            btn.layer.masksToBounds = false
            btn.layer.shadowColor = romDarkGray.cgColor
            btn.layer.shadowOpacity = 0.3
            btn.layer.shadowOffset = CGSize(width: 4, height: 4)
            btn.layer.shadowRadius = 4
            btn.layer.borderColor = palegray.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 30
            
        }
        
        
        // compare user info
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: compareUserId)
      
        // download romtype info
        let getMyRomtype = MyRomtype()
        getMyRomtype.delegate = self
        getMyRomtype.downloadMyRomtype(userid: userId)
        
        addCompareUser(compareUserId: compareUserId)
        
        compareResult.gradientColors = [romTeal.cgColor, romOrange.cgColor, romPink.cgColor]
        
        print (qrcodeString)
    }
   
    
    // do after load
    override func viewDidAppear(_ animated: Bool) {
        
        checkApprovals(compareUserId: compareUserId)
        
    }
    
    

    // view specific functions
    
    func compareRomtypes(romtype1: String, romtype2: String) {
        
        let compareType = "intro"
        let compareURLString = "https://romdat.com/compare/romtypes/\(romtype1)/\(romtype2)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId], urlString: compareURLString) { success, result in
            
            print (result)
            
            if result["success"] as! String == "yes" {
                
                print ("compare users")
                self.compareResult.text = result["result"] as! String
                self.compareUserImage.image = UIImage(named: "\(result["image"] as! String)")
            }
            
         }
        
        
    }
    
   
    func checkApprovals(compareUserId: String) {
        
        let compareType = "intro"
        let compareURLString = "https://romdat.com/compare/check/\(userId)/\(compareUserId)/\(compareType)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: compareURLString) { success, result in
            
            print (result)
            
            if result["success"] as! String == "yes" {
                print ("ok show the f'in thing")
                self.confirmNeeded.isHidden = true
            }
            else {
                if result["response"] as! String == "denied" {
                
                    self.waitingImage.image = UIImage(named: "compare-no-match_400x400.png")
                    self.waitingMessage.text = "Connection Denied"
                    
                }
                
            }
        
        }
        
    }
    
    
    func addCompareUser(compareUserId: String) {
        
        let compareType = "level-1"
        let compareURLString = "https://romdat.com/compare/add/\(userId)/\(compareUserId)/\(compareType)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: "https://romdat.com/compare/add/\(userId)/\(compareUserId)/\(compareType)") { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                print ("compare basic level 1 added")
 
            }
            
        }
        
    }
    
    
    func updateCompareUser(compareUserId: String, compareStatus: String) {
        
        let compareType = "level-1"
        let compareURLString = "https://romdat.com/compare/update/\(userId)/\(compareUserId)/\(compareType)/\(compareStatus)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: "https://romdat.com/compare/update/\(userId)/\(compareUserId)/\(compareType)/\(compareStatus)") { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                if (compareStatus == "approved") {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
                    
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
                let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
                
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
                
                self.compareUserImage.image = UIImage(data: data)
            }
        }
    }
    
}
