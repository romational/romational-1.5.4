//
//  RomtypeCompleteViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/24/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class RomtypeCompleteViewController: UIViewController, RomtypeQuestionProtocol, MyRomtypeAnswersProtocol {

    
    @IBAction func retakeClick(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
        
        destination.RQ = 1
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
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
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var confirmBox: UIView!
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var congratsText: GradientLabel!
    
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var viewReportButton: UIButton!
    
    @IBOutlet weak var viewReportBkgd: UIButton!
    @IBOutlet weak var retakeBkgd: UIButton!
    
    // button clicks
    @IBAction func viewReport(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeReport") as! RomtypeReportViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    }
    
    
    // arrays
    var buttons = [UIButton]()
    var bkgds = [UIButton]()
    
    
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmBox.isHidden = true
        
        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        congratsText.gradientColors = [romTeal.cgColor, romOrange.cgColor, romPink.cgColor]
        
        let myAnswers = MyRomtypeAnswers()
        myAnswers.delegate = self
        myAnswers.downloadMyRomtypeAnswers(userid: userId)
        
        
        bkgds.append(retakeBkgd)
        bkgds.append(viewReportBkgd)
        
        bkgds.forEach { btn in
            
            btn.layer.masksToBounds = false
            btn.layer.shadowColor = white.cgColor
            btn.layer.shadowOpacity = 0.8
            btn.layer.shadowOffset = CGSize(width: -4, height: -4)
            btn.layer.shadowRadius = 4
            
            btn.layer.borderColor = palegray.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 25
        }
        
        
        buttons.append(retakeButton)
        buttons.append(viewReportButton)
        
        buttons.forEach { button in

            button.layer.borderColor = white.cgColor
            button.layer.borderWidth = 1
            button.layer.masksToBounds = false
            
            button.layer.shadowColor = romDarkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowOpacity = 0.60
            button.layer.shadowRadius = 4
            
            button.layer.cornerRadius = 25
        }
        
       
    }
    

    // bring in myFactors
   var myRomtypeAnswers: NSArray = NSArray()
   
   func myRomtypeAnswersDownloaded(romtypeAnswers: NSArray) {
       myRomtypeAnswers = romtypeAnswers
       print (myRomtypeAnswers)
       
       let romtypeQuestions = RomtypeQuestions()
       romtypeQuestions.delegate = self
       romtypeQuestions.downloadQuestions()
       
   }
   
   var romtypeQuestions: NSArray = NSArray()
   
   func questionsDownloaded(questions: NSArray) {
       romtypeQuestions = questions

       var unlock = "yes"
       var questionCount = 0
       var answerCount = 0
       var selectivityCount = 0
       var unanswered: Array = [Int]()
       
       myRomtypeAnswers.forEach { rta  in
           let thisAnswer = rta as! MyRomtypeAnswersModel
           let answer = thisAnswer.answerId ?? "0"
           
           if Int(answer) == 0 || answer == "" {
               unlock = "no"
               answerCount += 1
               unanswered.append(questionCount)
           }
          
           questionCount += 1
           //print (unlock)
       }
       
       if unlock == "yes" {
           // save to logs
           confirmBox.isHidden = false
        
           // save to logs
           if (romtypeCompleted == "") {
               updateUserLogs(userid: userId, item: "romtype-completed")
           }
       }
       else {
            //confirmBox.isHidden = true
            let errorBox : UIView = UIView()
           
            errorBox.frame = CGRect(x: 20, y: 150, width: 350, height: 400)
            errorBox.backgroundColor = romLightGray
           
            background.addSubview(errorBox)
           
            errorBox.translatesAutoresizingMaskIntoConstraints = false

            errorBox.topAnchor.constraint(equalTo: background.topAnchor, constant: 150.0).isActive = true
            errorBox.centerXAnchor.constraint(equalTo: background.centerXAnchor, constant: 0.0).isActive = true
            errorBox.leadingAnchor.constraint(greaterThanOrEqualTo: background.leadingAnchor, constant: 10.0).isActive = true
            errorBox.trailingAnchor.constraint(greaterThanOrEqualTo: background.trailingAnchor, constant: 10.0).isActive = true
            errorBox.heightAnchor.constraint(greaterThanOrEqualToConstant: 400).isActive = true
            errorBox.widthAnchor.constraint(equalToConstant: 320).isActive = true
           
            let errorMessage: UILabel = UILabel()

            errorMessage.frame = CGRect(x: 10, y: 20, width: 300, height: 50)
            errorMessage.backgroundColor = UIColor.clear
            errorMessage.textAlignment = NSTextAlignment.center
            errorMessage.font = UIFont(name: "HelveticaNeue", size: 18)
            errorMessage.text = "You have \(answerCount) unanswered questions. Click to answer"
            errorMessage.numberOfLines = 0
            errorBox.addSubview(errorMessage)

            var labelPosition = 80

            unanswered.forEach { una in
                
               //print (una)
               let questionLabel = UILabel()
               questionLabel.frame = CGRect(x: 10, y: labelPosition, width: 300, height: 30)
               questionLabel.backgroundColor = white
               questionLabel.textAlignment = NSTextAlignment.center
              
               
               let thisQuestion = romtypeQuestions[una] as! RomtypeQuestionModel
               //print (thisFactor.name)
               questionLabel.text = "\(thisQuestion.name!)"
               
               questionLabel.isUserInteractionEnabled = true
               
               
               let recognizer = RomtypeIconGestureRecognizer(target: self, action: #selector(self.iconTap), rtqId: thisQuestion.order!)
               
               questionLabel.addGestureRecognizer(recognizer)
               
               errorBox.addSubview(questionLabel)
               
               labelPosition = labelPosition + 40
           }
           
       }
       
   }
       
    
    @objc func iconTap(gestureRecognizer: RomtypeIconGestureRecognizer)
    {
       
        print (gestureRecognizer.rtqId)
        
        let rtq = gestureRecognizer.rtqId
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
        secondViewController.RQ = rtq!
        
        //NewViewController create DisplayImg UIImageView object
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    class RomtypeIconGestureRecognizer : UITapGestureRecognizer {
        
        var rtqId : Int?
        // any more custom variables here
        
        init(target: AnyObject?, action: Selector, rtqId : Int) {
            super.init(target: target, action: action)
            
            self.rtqId = rtqId
        }
        
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
