//
//  FQIntroViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/6/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class FQIntroViewController: UIViewController, UserLogsProtocol, MyFactorsProtocol {
    
    
    var userLog : NSArray = NSArray()
    
    func UserLogsDownloaded(userLogs: NSArray) {
       userLog = userLogs
       
        print (flexibilityStarted)
        print (flexibilityCompleted)
        
        if (flexibilityStarted == "") {
            questionsBox.isHidden = true
            startBox.isHidden = false
            startButton.setTitle("Start", for: .normal)
            clearButton.isHidden = true
        }
        else if (flexibilityCompleted == "") {
            questionsBox.isHidden = true
            startBox.isHidden = false
            startButton.setTitle("Continue", for: .normal)
            clearButton.isHidden = true
        }
        else {
            questionsBox.isHidden = false
            startBox.isHidden = true
            clearButton.isHidden = false
        }
    
       
   }
    
    var answerCount = 0
    
    @IBOutlet weak var progress: UILabel!
    func myFactorAnswersDownloaded(factors: NSArray) {
       
        factors.forEach { factor in
            
            let myFactor = factor as! MyFactorAnswersModel
            
            print (myFactor.answerId!)
            
            // it is only 0 if no results for answer in array
            if Int(myFactor.answerId!)! != 0 {
                
                //FQ =  Int(myFactor.factorId!)!
                answerCount = answerCount + 1
            }
            
        }
        progress.text = ("\(answerCount) out of \(factors.count) completed")
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
    
    @IBOutlet var fqIntroView: UIView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var questionsBox: UIView!
    @IBOutlet weak var startBox: UIView!
    
    
    @IBOutlet weak var btnBkgd: UIView!
    @IBOutlet weak var btnShadow: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var fqIntroTitle: UILabel!
    @IBOutlet weak var fqIntroText: UILabel!
    
    @IBOutlet weak var whatIsFlexibility: UILabel!
    @IBOutlet weak var aboutFlexibility: UILabel!
    
    // buttons
    @IBAction func getStarted(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @IBOutlet weak var clearButton: UIButton!
    @IBAction func clearAnswers(_ sender: Any) {
    
        let popupTitle  =  "Clear Your Answers?"
        let popupInfo   = "Are you sure you want to clear your answers? (this cannot be undone)"
        
        let popupButton =  "Oops, No, Don't Clear"

        // create popup button
        let alertController:UIAlertController = UIAlertController(title: popupTitle, message: popupInfo, preferredStyle: UIAlertController.Style.alert)

        let alertAction:UIAlertAction = UIAlertAction(title: popupButton, style: UIAlertAction.Style.default, handler:nil)

        // add second button (with controller link)
        alertController.addAction(UIAlertAction(title: "Yes, Clear Them", style: .default, handler: { (action) in

            postWithCompletion(parameters: [userId], urlString: "https://romdat.com/user/\(userId)/selectivity/clear") { success, result in
            
                if (result["success"] as! String == "yes") {
                    flexibilityStarted = ""
                    flexibilityCompleted = ""
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destination = storyboard.instantiateViewController(withIdentifier: "FQIntro") as! FQIntroViewController
                    destination.modalPresentationStyle = .fullScreen
                    self.present(destination, animated: false)
                }
            }


        }))
        // end add 2nd button
        
        alertController.addAction(alertAction)
                
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        // reload the user logs
        let getUserLogs = UserLogs()
        getUserLogs.delegate = self
        getUserLogs.downloadUserLogs()
        
        startBox.isHidden = true
        questionsBox.isHidden = true
        clearButton.isHidden = true
        
        // page info
        let pageInfo = VCS["FQIntro"] as? VCSInfoModel
       
        if (pageInfo?.title != nil) {
           //fqIntroTitle.text = pageInfo!.title
        }
        if (pageInfo?.info != nil) {
            
            fqIntroText.text = pageInfo!.info
        }
        
        
        let myFactorAnswers = MyFactorAnswers()
        myFactorAnswers.delegate = self
        myFactorAnswers.downloadMyFactorAnswers(userid: userId)
        
        
        let popupInfo   = pageInfo!.popup ?? "n/a"
        let popupTitle  = pageInfo!.popupTitle ?? "More Info"
        //let popupButton = pageInfo!.popupButton ?? "Ok, Got It"
        
        whatIsFlexibility.text = popupTitle
        aboutFlexibility.text = popupInfo
        
        
        // start btn styling
        btnBkgd.layer.masksToBounds = false
        btnBkgd.layer.shadowColor = white.cgColor
        btnBkgd.layer.shadowOpacity = 0.9
        btnBkgd.layer.shadowOffset = CGSize(width: -8, height: -4)
        btnBkgd.layer.shadowRadius = 4
        
        btnBkgd.layer.borderColor = palegray.cgColor
        btnBkgd.layer.borderWidth = 2
        btnBkgd.layer.cornerRadius = 30
    
        btnShadow.layer.masksToBounds = false
        btnShadow.layer.shadowColor = romDarkGray.cgColor
        btnShadow.layer.shadowOpacity = 0.3
        btnShadow.layer.shadowOffset = CGSize(width: 4, height: 4)
        btnShadow.layer.shadowRadius = 4
        
        //button.layer.borderColor = white.cgColor
        //button.layer.borderWidth = 1
        btnShadow.layer.cornerRadius = 30
        
        clearButton.layer.masksToBounds = false
        clearButton.layer.shadowColor = romDarkGray.cgColor
        clearButton.layer.shadowOpacity = 0.3
        clearButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        clearButton.layer.shadowRadius = 4
        clearButton.layer.cornerRadius = 20
        
        // clear return link
        goBack = ""
        
        
    }
    

  
}
