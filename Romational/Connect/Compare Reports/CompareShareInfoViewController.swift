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
    
    @IBOutlet weak var shareButton: UIButton!
    
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

    
    var buttons = [UIButton]()
    
    
    @IBAction func refreshView(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareShareInfo") as! CompareShareInfoViewController
        
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
    
    
    // view vars
    
    var compareUserId = ""
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    // report link
    @IBOutlet weak var fullReportButton: UIButton!
    @IBAction func viewFullReport(_ sender: Any) {
    
        self.getPDFlink()
    
    }
    
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        shareButton.underline()
        
        // compare user info
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: compareUserId)
        
        
        //buttons.append(endButton)
        //buttons.append(continueButton)
        buttons.append(refreshButton)
        buttons.append(myComparesButton)
        buttons.append(fullReportButton)
        
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
        
    }
    
    
    // view functions
    
    func checkApprovals(compareUserId: String) {
        
        let compareType = "level-3"
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
    
    // report links
    func emailPDFlink() {
        let urlPath = "http://romadmin.com/createEmailPDF.php?userid=\(compareUserId)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("PDF emailed ")
                print (data)
                DispatchQueue.main.async(execute: { () -> Void in
                
                    self.shareButton.setTitle("Emailed", for: .normal)
                    self.shareButton.backgroundColor = orange
                    self.shareButton.setTitleColor(white, for: .normal)
                    self.shareButton.tintColor = white
                    self.shareButton.layer.cornerRadius = 20
                    
                    /*
                    self.shareButton.setImage(nil, for: .normal)
                    self.shareButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
                    self.shareButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
                    self.shareButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
                    */
                    
                    self.view.setNeedsLayout()
                    
                })
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getPDFlink() {
        let urlPath = "http://www.romadmin.com/createPDF.php?userid=\(compareUserId)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("PDF link created")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.parseJSON(data!)
                })
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = String()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! String
            
        } catch let error as NSError {
            print(error)
            
        }
        
        if jsonResult != "" {
            let pdflink = jsonResult
            print (pdflink)
            DispatchQueue.main.async(execute: { () -> Void in

                // go to the link for the PDF report
                UIApplication.shared.openURL(URL(string: pdflink)!)
                
            })
        }
    }

}
