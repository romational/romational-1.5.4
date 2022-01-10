//
//  CompareLevelTwoViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/7/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class CompareLevelTwoViewController: UIViewController, MyDemosProtocol, MyRomtypeProtocol, CompareRomtypeProtocol {

    // download
    
    var myDemoInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        
        myDemoInfo = demoInfo
        //print (myDemoInfo)
        
        if (myDemoInfo.count > 0) {
            let profile = (myDemoInfo[0] as? MyDemosModel)!
            
            //print (profile)
            // name config
            if (profile.nickName != nil) {
               
                them.setTitle( profile.nickName!, for: .normal)
            }
            else {
               
                them.setTitle( profile.nameFirst!, for: .normal)
            }
            
       
        }
        
    }
    
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
            
     
            if firstImage != nil {
                myRomType.image = UIImage(named: "\(firstImage!)")
            }
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
        //print (compareRomtype)
        if let first = compareRomtype[0] as? [String: Any] {
    
            let firstImage  = first["image"] as? String
            let firstName   = first["name"] as? String
            romtype2 = (first["type"] as? String)!
            let firstInfo   = first["info"] as? String
            let firstDefine = first["define"] as? String
    
        
            if firstImage != nil {
                theirRomType.image = UIImage(named: "\(firstImage!)")
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
        self.slideController.didMove(toParent: self)
            
        showMenu = true
       
    }
    
    // level navs
    
    @IBOutlet weak var L2Button: UIButton!
    
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
    
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var myComparesButton: UIButton!
    
    // button actions
    @IBAction func refreshView(_ sender: Any) {
    
       
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
        
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
    
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    // button actions
    @IBAction func endConnection(_ sender: Any) {
      
        updateCompareUser(compareUserId: compareUserId, compareStatus: "denied")
        
    }
    
    @IBAction func doContinue(_ sender: Any) {
     
        updateCompareUser(compareUserId: compareUserId, compareStatus: "approved")
        
    }
    
    var buttons = [UIButton]()
    
    
    // romType vars
    
    var compareUserId = ""
    
    @IBOutlet weak var romTypeAssessment: UILabel!

    @IBOutlet weak var myRomType: UIImageView!
    @IBOutlet weak var theirRomType: UIImageView!
    
    @IBOutlet weak var them: UIButton!
    
    @IBOutlet weak var romTypeOutOf: UILabel!
    @IBOutlet weak var romTypeInCommon: UILabel!
    

    
    // flexScore
    @IBOutlet weak var flexScoreAssessment: UILabel!
    
    @IBOutlet weak var myFlexScore: UILabel!
    @IBOutlet weak var theirFlexScore: UILabel!
    
    @IBOutlet weak var flexScoreOutOf: UILabel!
    @IBOutlet weak var flexScoreInCommon: UILabel!
    
    
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        L2Button.underline()
        
        // this add this level to user compares (if none exists)
        addCompareUser(compareUserId: compareUserId)
        
        
        // my info
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: compareUserId)
        
        // kick off bring in romtypes (daisy chained)
        let getMyRomtype = MyRomtype()
        getMyRomtype.delegate = self
        getMyRomtype.downloadMyRomtype(userid: userId)
        
        
        buttons.append(endButton)
        buttons.append(continueButton)
        buttons.append(refreshButton)
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
        
    }
    

    
    // do after load
    override func viewDidAppear(_ animated: Bool) {
        
        checkApprovals(compareUserId: compareUserId)
        
        getMyFlexScore()
        getTheirFlexScore()
     
        compareFactorAnswers()
        compareRomTypeAnswers()
        
    }
    
   
    
    // view setup (levels) functions
   
    func checkApprovals(compareUserId: String) {
        
        let compareType = "level-1"
        let compareURLString = "https://romdat.com/compare/check/\(userId)/\(compareUserId)/\(compareType)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: compareURLString) { success, result in
            
            print (result)
            
            if result["success"] as! String == "yes" {
                print ("ok show the f'in thing")
                self.confirmNeeded.isHidden = true
                //self.compareFactors(userId: userId, compareUserId: compareUserId)
                
                
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
        
        let compareType = "level-2"
        let compareURLString = "https://romdat.com/compare/add/\(userId)/\(compareUserId)/\(compareType)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: "https://romdat.com/compare/add/\(userId)/\(compareUserId)/\(compareType)") { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                print ("compare factors level 2 added")
 
            }
            
         }
        
        
    }
    
    func updateCompareUser(compareUserId: String, compareStatus: String) {
        
        let compareType = "level-2"
        let compareURLString = "https://romdat.com/compare/update/\(userId)/\(compareUserId)/\(compareType)/\(compareStatus)"
        print (compareURLString)
        
        postWithCompletion(parameters: [userId, compareUserId, compareType], urlString: "https://romdat.com/compare/update/\(userId)/\(compareUserId)/\(compareType)/\(compareStatus)") { success, result in
            
            print (result)
            
            if result["success"] as! String == "ok" {
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "CompareL3") as! CompareLevelThreeViewController
                
                destination.compareUserId = compareUserId
                
                destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false)
            }
                
            if result["success"] as! String == "yes" {
                
                if (compareStatus == "approved") {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destination = storyboard.instantiateViewController(withIdentifier: "CompareL3") as! CompareLevelThreeViewController
                    
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
            
         }
        
        
    }
    
    @IBOutlet weak var mySelectivity: UIButton!
    @IBOutlet weak var theirSelectivity: UIButton!
    
    
    // scoring specific functions
    
    func getMyFlexScore()  {
        
        let compareURLString = "https://romdat.com/user/\(userId)/flexScore"
        //print (compareURLString)
        
        postWithCompletion(parameters: [userId], urlString: compareURLString) { [self] success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
               
                print ("flexScore \(result["flexScore"]) ")
                
                self.myFlexScore.text = String(Int(Double(result["flexScore"] as! String)! * 100))
                
                selectivityIndex = Int(Double(result["flexScore"] as! String)! * 100)
                
                flexbilityColors(flexScoreLabel: myFlexScore, flexibility: Int(Double(result["flexScore"] as! String)! * 100))
             
                //print ("ranges here")
                for i in 0..<Ranges.count {
                    
                    let thisRange = Ranges[i] as? NSDictionary
                    
                    //print (thisRange!["low"]!)
                    let rangeName = thisRange!["name"] as? String
                    let lowRange  = Int((thisRange!["low"] as? String)!)!
                    let highRange = Int((thisRange!["high"] as? String)!)!
                    let rangeInfo = thisRange!["info"] as? String
                    
                    if (selectivityIndex > lowRange) && (selectivityIndex <= highRange) {
                        print ("hello \(lowRange) \(highRange)")
                        mySelectivity.setTitle(rangeName!, for: .normal)
                        
                    }
                }
                
            }
        }
    }
    
    func getTheirFlexScore()  {
        
        let compareURLString = "https://romdat.com/user/\(compareUserId)/flexScore"
        //print (compareURLString)
        
        postWithCompletion(parameters: [userId], urlString: compareURLString) { [self] success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
               
                print ("flexScore \(result["flexScore"]) ")
                
                self.theirFlexScore.text = String(Int(Double(result["flexScore"] as! String)! * 100))
                
                selectivityIndex = Int(Double(result["flexScore"] as! String)! * 100)
                
                flexbilityColors(flexScoreLabel: theirFlexScore, flexibility: Int(Double(result["flexScore"] as! String)! * 100))
                
                
                //print ("ranges here")
                for i in 0..<Ranges.count {
                    
                    let thisRange = Ranges[i] as? NSDictionary
                    
                    //print (thisRange!["low"]!)
                    let rangeName = thisRange!["name"] as? String
                    let lowRange  = Int((thisRange!["low"] as? String)!)!
                    let highRange = Int((thisRange!["high"] as? String)!)!
                    let rangeInfo = thisRange!["info"] as? String
                    
                    if (selectivityIndex  > lowRange) && (selectivityIndex  <= highRange) {
                        
                        theirSelectivity.setTitle(rangeName!, for: .normal)
                        
                    }
                }
                
            }
        }
    }
    
    
    func compareRomTypeAnswers() {
     
        let compareURLString = "https://romdat.com/compare/answers/romtypes/\(userId)/\(compareUserId)"
        //print (compareURLString)
        
        postWithCompletion(parameters: [userId], urlString: compareURLString) { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                var matchCt = 0
                
                print ("ok lets sort through them")
                
                let compareResults = result["compareRomtypeQs"] as! [[String:Any]]
                
              
                
                compareResults.forEach { cr in
                    //print (cr["rtqId"])
                    //print ("\(cr["myAnswerId"]) -  \(cr["myAnswer"])")
                    //print ("\(cr["theirAnswerId"]) - \(cr["theirAnswer"])")
                    
                    if (cr["myAnswerId"] as? Int != nil) && (cr["theirAnswerId"] as? Int != nil) {
                        if cr["myAnswerId"] as! Int == cr["theirAnswerId"] as! Int {
                            matchCt = matchCt + 1
                        }
                    }
                    
                    self.romTypeOutOf.text = ("\(matchCt) out of \(compareResults.count)")
                }
               
            }
            else {
                
                
            }
        
        }
        
    }
    
    func compareFactorAnswers() {
        
 
        let compareURLString = "https://romdat.com/compare/answers/factors/\(userId)/\(compareUserId)"
        //print (compareURLString)
        
        postWithCompletion(parameters: [userId], urlString: compareURLString) { success, result in
            
            //print (result)
            
            if result["success"] as! String == "yes" {
                
                var matchCt = 0
                
                //print ("ok lets sort through them")
                
                let compareResults = result["compareFactors"] as! [[String:Any]]
                
                compareResults.forEach { cr in
                    //print (cr["factorId"])
                    //print ("\(cr["myAnswerId"]) -  \(cr["myAnswer"])")
                    //print ("\(cr["theirAnswerId"]) - \(cr["theirAnswer"])")
                    
                    if (cr["myAnswerId"] as? Int != nil) && (cr["theirAnswerId"] as? Int != nil) {
                        if cr["myAnswerId"] as! Int == cr["theirAnswerId"] as! Int {
                            matchCt = matchCt + 1
                        }
                    }
                    
                    self.flexScoreOutOf.text = ("\(matchCt) out of \(compareResults.count)")
                }
               
            }
            else {
                
                
            }
        
        }
        
    }
    

    

}
