//
//  CompareViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 5/28/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, MyDemosProtocol, MyComparesProtocol, MyRequestsProtocol {

    
    // user demo info
    
    // MARK: download profile info
    
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
    
    
    var compareUserId = 0
    
    var y = CGFloat(0)
    
    // download compares
    var myComparesList: NSArray = NSArray()
    
   
    
    func myComparesDownloaded(myCompares: NSArray) {
        myComparesList = myCompares
        
        y  = navBar.frame.origin.y + 150
        let x  =  navBar.frame.origin.x

        let vcWidth   = view.bounds.width
        let vcHeight = view.bounds.height
        
        myComparesList.forEach { req in
            let thisCompare = req as! MyComparesModel
            
            compareUserId = thisCompare.userId!
            
            if thisCompare.introStatusMe == "undecided" {
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Intro Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoIntroCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                
                y = y + 70
                
            }
            else if  thisCompare.level1StatusMe == "undecided" && thisCompare.introStatusThem != "undecided" {
                
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Level 1 Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoRomtypeCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
    
                
                y = y + 70
            }
            
            else if  thisCompare.level2StatusMe == "undecided" && thisCompare.level1StatusThem != "undecided" {
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Level 2 Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
               
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoFactorsCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                
                y = y + 70
                
            }
            
            else if  thisCompare.level3StatusMe == "undecided" && thisCompare.level2StatusThem != "undecided" {
                let newActionNeeded = UIButton(frame: CGRect(x: 10, y: y, width: vcWidth-20, height: 60))
                newActionNeeded.setTitle ( "Action needed on an Level 3 Compare", for: .normal)
                newActionNeeded.layer.backgroundColor = romTeal.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoFullCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                y = y + 70
                
            }
        }
       
        // my requests (run here so it loads after compares finish)
        let getMyRequests = MyRequests()
        getMyRequests.delegate = self
        getMyRequests.downloadMyRequests()
        
    }
    
    
    // download requests
    var myRequestsList: NSArray = NSArray()
    
    func myRequestsDownloaded(myRequests: NSArray) {
        myRequestsList = myRequests
        
        
        let x  =  navBar.frame.origin.x

        let vcWidth   = view.bounds.width
        let vcHeight = view.bounds.height
        
        var reqCt = 0
        
        myRequestsList.forEach { req in
            let thisReq = req as! MyRequestsModel
            
            compareUserId = thisReq.compareUserId!
            
            
            /*
            if thisReq.introStatusMe == "undecided" {
                reqCt = reqCt + 1
            }
            else if thisReq.level1StatusMe == "undecided" {
                reqCt = reqCt + 1
            }
            else if thisReq.level2StatusMe == "undecided" {
                reqCt = reqCt + 1
            }
            else if thisReq.level3StatusMe == "undecided" {
                reqCt = reqCt + 1
            }
            else {
                
            }
            */
            
            if thisReq.introStatusMe == "undecided" || thisReq.introStatusMe == "new" {
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on an Intro Request", for: .normal)
                newActionNeeded.layer.backgroundColor = romPink.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoIntroCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                
                y = y + 70
                
            }
            
            else if  (thisReq.level1StatusMe == "undecided" ||  thisReq.level1StatusMe == "new") && (thisReq.introStatusThem != "undecided" && thisReq.introStatusThem != "new") {
                
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on a Level 1 Request", for: .normal)
                newActionNeeded.layer.backgroundColor = romPink.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoRomtypeCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
    
                
                y = y + 70
            }
            
            else if  (thisReq.level2StatusMe == "undecided" || thisReq.level2StatusMe == "new") && (thisReq.level1StatusThem != "undecided" && thisReq.level1StatusThem != "new") && (thisReq.introStatusThem != "undecided" && thisReq.introStatusThem != "new" ) {
                let newActionNeeded = UIButton(frame: CGRect(x: 0, y: y, width: vcWidth, height: 60))
                newActionNeeded.setTitle( "Action needed on a Level 2 Request", for: .normal)
                newActionNeeded.layer.backgroundColor = romPink.withAlphaComponent(0.9).cgColor
               
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoFactorsCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                
                y = y + 70
                
            }
            
            else if  (thisReq.level3StatusMe == "undecided" || thisReq.level3StatusMe == "new") && (thisReq.level2StatusThem != "undecided" && thisReq.level2StatusThem != "new" ) && (thisReq.level1StatusThem != "undecided" && thisReq.level1StatusThem != "new" ) && (thisReq.introStatusThem != "undecided" && thisReq.introStatusThem != "new" ) {
                let newActionNeeded = UIButton(frame: CGRect(x: 10, y: y, width: vcWidth-20, height: 60))
                newActionNeeded.setTitle ( "Action needed on a Level 3 Request", for: .normal)
                newActionNeeded.layer.backgroundColor = romPink.withAlphaComponent(0.9).cgColor
                
                newActionNeeded.tag = compareUserId
                newActionNeeded.addTarget(self, action: #selector(gotoFullCompare(sender:)), for: .touchUpInside)
                
                view.addSubview(newActionNeeded)
                y = y + 70
                
            }
            
            
        }
        /*
        newReqs.text = ("\(reqCt)")
        
        if reqCt > 0 {
            newReqs.isHidden = false
            newReqs.layer.cornerRadius = 10
        }
         */
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
   
    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var myQRCodeBkgd: UIButton!
    @IBOutlet weak var enterCodeBkgd: UIButton!
    @IBOutlet weak var scannerBkgd: UIButton!
    @IBOutlet weak var myComparesBkgd: UIButton!

    var bkgds = [UIButton]()
    
    @IBOutlet weak var myQRCodeButton: UIButton!
    @IBOutlet weak var enterCodeButton: UIButton!
    @IBOutlet weak var scannerButton: UIButton!
    @IBOutlet weak var myComparesButton: UIButton!
    
    var buttons = [UIButton]()
    
    @IBOutlet weak var newConnects: UILabel!
    
    
    // button clicks
    
    @IBAction func gotoScan(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Scanner") as! ScannerViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)

    }
    
    @IBAction func gotoCompares(_ sender: Any) {
  
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "MyCompares") as! MyComparesViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoMyQRCode(_ sender: Any) {
  
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "MyQRCode") as! MyQRCodeViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func enterCode(_ sender: Any) {
  
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "EnterCode") as! EnterCodeViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    
    // load view
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // my compares
        let getMyCompares = MyCompares()
        getMyCompares.delegate = self
        getMyCompares.downloadMyCompares()
      
        
        
        // connect icon
        newConnects.isHidden = true
        newConnects.layer.cornerRadius = 10
        newConnects.layer.masksToBounds = true
        
        // button styling
        bkgds.append(myQRCodeBkgd)
        bkgds.append(enterCodeBkgd)
        bkgds.append(scannerBkgd)
        bkgds.append(myComparesBkgd)
        
        bkgds.forEach { bkgd in
            // sign in button bkgds
            bkgd.layer.borderColor = white.cgColor
            bkgd.layer.borderWidth = 4
            bkgd.layer.cornerRadius = 30
            
            bkgd.layer.masksToBounds = false
            bkgd.layer.shadowColor = white.cgColor
            bkgd.layer.shadowOpacity = 0.80
            bkgd.layer.shadowOffset = CGSize(width: -4, height: -4)
            bkgd.layer.shadowRadius = 4
        }
        
        buttons.append(myQRCodeButton)
        buttons.append(enterCodeButton)
        buttons.append(scannerButton)
        buttons.append(myComparesButton)
        
        buttons.forEach { btn in
        
            // sign in button box
            btn.layer.masksToBounds = false
            btn.layer.shadowColor = romDarkGray.cgColor
            btn.layer.shadowOpacity = 0.3
            btn.layer.shadowOffset = CGSize(width: 4, height: 4)
            btn.layer.shadowRadius = 4
            btn.layer.borderColor = palegray.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 30

        }
        
        // bring in user profile
        
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: userId)
        
        
        //userImage.image = generateQRCode(from: "http://romational.com?userId=\(userId)")
        
    }
    
    // do after load
    override func viewDidAppear(_ animated: Bool) {
        
        checkNewCompares()
        
    }
    
    
    // view fucntions
    
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

    
    // compare links
    @objc func gotoIntroCompare(sender: UIButton){
        let compareUserId = sender.tag
        
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareIntro") as! CompareIntroViewController
        
        destination.compareUserId = String(compareUserId)
        destination.qrcodeString = "https://www.romational.com?userId=\(compareUserId)"
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @objc func gotoRomtypeCompare(sender: UIButton){
        let compareUserId = sender.tag
        
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
        
        destination.compareUserId = String(compareUserId)
        destination.qrcodeString = "https://www.romational.com?userId=\(compareUserId)"
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @objc func gotoFactorsCompare(sender: UIButton){
        let compareUserId = sender.tag
    
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @objc func gotoFullCompare(sender: UIButton){
        let compareUserId = sender.tag
    
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL3") as! CompareLevelThreeViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    

    // view specific functions
    
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
