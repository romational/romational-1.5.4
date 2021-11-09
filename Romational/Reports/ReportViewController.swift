//
//  ReportViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 11/25/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,  UserLogsProtocol, MyDemosProtocol, MyRomtypeProtocol, MyFactorsProtocol, UICollectionViewDelegate {

    
    // downloads
    
    // bring in romtype info
    var myRomtype = NSArray()
    
    func myRomtypeDownloaded(myRomtypeInfo: NSArray) {
        
        if myRomtypeInfo != nil {
            
            myRomtype = myRomtypeInfo
            //print (myRomtype)
            
            if let first = myRomtype[0] as? [String: Any] {
        
                let firstImage = first["image"] as? String
                let firstName = first["name"] as? String
                let firstInfo = first["info"] as? String
                
                //print ("image is \(firstImage!)")
                if firstImage != nil {
                    myRomtypeBox.image = UIImage(named: "\(firstImage!)")
                }
            }
        }
    
    }
    
    var myFactors: NSArray = NSArray()
    var selectivity = 0.0
    
    func myFactorAnswersDownloaded(factors: NSArray) {
    
        myFactors = factors
        if factors.count > 0 {
            for factor in myFactors {
                //for (index,factor) in factors.enumerated() {

                var factorAnswer = factor as! MyFactorAnswersModel
                
                let importance = Double(factorAnswer.selectivity!)!

                selectivity += importance * 100

            }
        }
        //print ("selectivity is \(selectivity)")
        //print ("factors is \(myFactors.count)")
        
        let selectivityIndex = Int(round(selectivity / Double(myFactors.count)))
        //print (selectivityIndex)
        
        flexbilityColors(flexScoreLabel: selectivityColorBox, flexibility: selectivityIndex)
        
        /*
        //print ("ranges here")
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            selectivityColorBox.layer.cornerRadius = 20
            selectivityColorBox.layer.masksToBounds = true
            
            //let rangeName = thisRange!["name"] as? String
            let lowRange  = Int((thisRange!["low"] as? String)!)!
            let highRange = Int((thisRange!["high"] as? String)!)!
        
            if (selectivityIndex > lowRange) && (selectivityIndex <= highRange) {
               
                if i == 0 {
                    selectivityColorBox.layer.borderWidth = 2
                    selectivityColorBox.layer.borderColor = yellow.cgColor
                   //selectivityColorBox.backgroundColor = yellow
                }
                if i == 1 {
                    selectivityColorBox.layer.borderWidth = 2
                    selectivityColorBox.layer.borderColor = green.cgColor
                    //selectivityColorBox.backgroundColor = green
                }
                if i == 2 {
                    selectivityColorBox.layer.borderWidth = 2
                    selectivityColorBox.layer.borderColor = teal.cgColor
                    //selectivityColorBox.backgroundColor = teal
                }
                if i == 3 {
                    selectivityColorBox.layer.borderWidth = 2
                    selectivityColorBox.layer.borderColor = navy.cgColor
                    //selectivityColorBox.backgroundColor = navy
                }
                if i == 4 {
                    selectivityColorBox.layer.borderWidth = 2
                    selectivityColorBox.layer.borderColor = purple.cgColor
                   // selectivityColorBox.backgroundColor = purple
                }
            }
        }
            */
        
        selectivityColorBox.text = String(selectivityIndex)
        
        self.removeSpinner()
        
    }
   
    
    var myInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        myInfo = demoInfo
    
        let profile = (myInfo[0] as? MyDemosModel)!
       
        print (profile)
        let urlString = "http://romadmin.com/images/users/\(profile.userImage!)"
        
        print (urlString)
        //print (profile.userImage)
        
        if (profile.userImage != "") {
            if let url = URL(string: urlString) {
            
                downloadImage(from: url)
                
                //self.userTypeImage.clipsToBounds = true
                //self.userTypeImage.layer.cornerRadius = 30
                
                //self.userTypeImage.addBkgdShadowToImage(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 80, shadowSize: 4)
            }
        }
        
        if profile.nickName! != "" {
            userName.text = "\(profile.nickName!)"
        }
        else {
            userName.text = "no username"
        }
        
    }

 
    var userLog : NSArray = NSArray()
    
   func UserLogsDownloaded(userLogs: NSArray) {
       userLog = userLogs
       
       //print (userLog)
       
    
        // lock buttons
        if (romtypeCompleted == "") {
            //btnBkgd1.backgroundColor = medgray
            romtypeLock.image = UIImage(named: "menu-lock-gray")
        }
        else {
            //btnBkgd1.backgroundColor = lightgray
            romtypeLock.image = UIImage(named: "")
            myRomtypeBox.isHidden = false
        }
        
        if (flexibilityCompleted == "") {
            //btnBkgd2.backgroundColor = medgray
            flexibilityLock.image = UIImage(named: "menu-lock-gray")
        }
        else {
           //- btnBkgd2.backgroundColor = lightgray
            flexibilityLock.image = UIImage(named: "")
            selectivityColorBox.isHidden = false
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
    
    @IBAction func gotoMyAnswers(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyRomtypeData") as! MyRomtypeDataViewController
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
    
    
   @IBAction func getInfo(_ sender: Any) {
        
        let pageInfo = VCS["ReportMenu"] as! VCSInfoModel
        // setup info popup
        
        let popupInfo   = pageInfo.popup ?? "n/a"
        let popupTitle  = pageInfo.popupTitle ?? "More Info"
        let popupButton = pageInfo.popupButton ?? "Ok, Got It"
        
        let alertController:UIAlertController = UIAlertController(title: popupTitle, message: popupInfo, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: popupButton, style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // view vars
    
    @IBOutlet weak var userTypeImage: UIImageView!
    
    
    @IBOutlet weak var myRomtypeBox: UIImageView!
    @IBOutlet weak var selectivityColorBox: UILabel!

    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var reportIntroTitle: UILabel!
    @IBOutlet weak var reportIntroText: UILabel!
   
    @IBAction func viewRomtypeReport(_ sender: Any) {
    
        if (romtypeCompleted == "") {
            
            let message = "Finish answering all the questions to unlock this report"
            let alertController:UIAlertController = UIAlertController(title: "Report Locked", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction:UIAlertAction = UIAlertAction(title: "OK, Got It", style: UIAlertAction.Style.default, handler:nil)
            
            alertController.addAction(UIAlertAction(title: "Answer Now", style: .default, handler: { (action) in

                // go back to the login view controller
                // go back through the navigation controller

            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "RTQIntro") as! RTQIntroViewController
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false)


            }))
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeReport") as! RomtypeReportViewController
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false)
        }
    
    }
    
    @IBAction func viewSelectivityReport(_ sender: Any) {
       
        if (flexibilityCompleted == "") {
            
            let message = "Finish answering all the questions to unlock this report"
            let alertController:UIAlertController = UIAlertController(title: "Report Locked", message: message, preferredStyle: UIAlertController.Style.alert)
            let alertAction:UIAlertAction = UIAlertAction(title: "OK, Got It", style: UIAlertAction.Style.default, handler:nil)
            
            alertController.addAction(UIAlertAction(title: "Answer Now", style: .default, handler: { (action) in

                    // go back to the login view controller
                    // go back through the navigation controller

                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "FQIntro") as! FQIntroViewController
                destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false)


                }))
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else {
          
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityScore") as! SelectivityViewController
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false)
       }
        
    }
    
    
    // MARK: view variables
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var romtypeButton: UIButton!
    @IBOutlet weak var flexibilityButton: UIButton!
    @IBOutlet weak var myAnswersButton: UIButton!
    
    @IBOutlet weak var romtypeLock: UIImageView!
    @IBOutlet weak var flexibilityLock: UIImageView!
    
    var buttons = [UIButton]()
    
    
    @IBOutlet weak var btnBkgd1: UIView!
    @IBOutlet weak var btnBkgd2: UIView!
    @IBOutlet weak var btnBkgd3: UIView!
    
    var bkgds = [UIView]()
    
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // load page details
        let pageInfo = VCS["ReportMenu"] as? VCSInfoModel
        
        if (pageInfo?.title != nil) {
            
            //reportIntroTitle.text = pageInfo!.title
        }
        
        if (pageInfo?.info != nil) {
             
            reportIntroText.text = pageInfo!.info
        }
        
       
        //navBar.layer.masksToBounds = false
        //navBar.layer.shadowColor = black.cgColor
        //navBar.layer.shadowOpacity = 0.6
        //navBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        //navBar.layer.shadowRadius = CGFloat(4)
    
        
        // morphs array
        bkgds.append(btnBkgd1)
        bkgds.append(btnBkgd2)
        bkgds.append(btnBkgd3)
        
        bkgds.forEach { bkgd in
        
            bkgd.layer.masksToBounds = false
            bkgd.layer.shadowColor = white.cgColor
            bkgd.layer.shadowOpacity = 0.6
            bkgd.layer.shadowOffset = CGSize(width: -6, height: -6)
            bkgd.layer.shadowRadius = 8
            
            bkgd.layer.borderColor = palegray.cgColor
            bkgd.layer.borderWidth = 2
            bkgd.layer.cornerRadius = 30
        }
        
        
        // button array
        buttons.append(romtypeButton)
        buttons.append(flexibilityButton)
        buttons.append(myAnswersButton)
        
        // add button styling
        buttons.forEach { button in
            
            //button.layer.backgroundColor =
            button.layer.masksToBounds = false
            button.layer.shadowColor = romDarkGray.cgColor
            button.layer.shadowOpacity = 0.6
            button.layer.shadowOffset = CGSize(width: 6, height: 6)
            button.layer.shadowRadius = 4
            
            button.layer.borderColor = palegray.cgColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 30
        }
        

        // reload the user logs
        let getUserLogs = UserLogs()
        getUserLogs.delegate = self
        getUserLogs.downloadUserLogs()
        
        myRomtypeBox.isHidden = true
        selectivityColorBox.isHidden = true
        
        userTypeImage.image = UIImage(named:"profile-placeholder-sq.png")
        userTypeImage.addBkgdShadowToImage(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 80, shadowSize: 4)
        userTypeImage.layer.cornerRadius = 30
        
        userTypeImage.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        userTypeImage.addGestureRecognizer(tapGestureRecognizer)
        
        self.showSpinner(onView: self.view)
        
        // bring in user profile
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: userId)
        
        let getMyRomtype = MyRomtype()
        getMyRomtype.delegate = self
        getMyRomtype.downloadMyRomtype(userid: userId)
        
        let myFactors = MyFactorAnswers()
        myFactors.delegate = self
        myFactors.downloadMyFactorAnswers(userid: userId)
        
        
        
        /*
        print ("print locks")
        // lock buttons
        if (romtypeCompleted == "") {
            romtypeLock.image = UIImage(named: "menu-lock-gray")
            //btnBkgd1.backgroundColor = medgray
            print ("locked")
        }
        else {
            romtypeLock.image = UIImage(named: "")
            //btnBkgd1.backgroundColor = lightgray
            print ("unlocked")
        }
        
        if (flexibilityCompleted == "") {
            flexibilityLock.image = UIImage(named: "menu-lock-gray")
            //btnBkgd2.backgroundColor = medgray
            print ("locked")
        }
        else {
            flexibilityLock.image = UIImage(named: "")
           // btnBkgd2.backgroundColor = lightgray
            print ("unlocked")
        }
        */
        
    }
    
    
    
    // MARK: image downloading
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        print("did tap image view", sender)
       
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let cgimage = image.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
    
    
    func downloadImage(from url: URL) {
       
        print("Download Started")
       
        getData(from: url) { data, response, error in
           guard let data = data, error == nil else { return }
          
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print (data)
            print("Download Finished")
            
            // try to fetch the user image
           DispatchQueue.main.async() {
                
                let imageWidth  = self.userTypeImage.frame.width
                let imageHeight = self.userTypeImage.frame.height
            
                if UIImage(data: data) != nil {
                    self.userTypeImage.image = self.cropToBounds(image: UIImage(data: data)!, width: Double(imageWidth), height: Double(imageHeight))
                
                    //self.userTypeImage.clipsToBounds = true

                    self.userTypeImage.addBkgdShadowToImage(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 80, shadowSize: 4)
                    self.userTypeImage.layer.cornerRadius = 30
                }
           }
       }
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

