//
//  FactorCompleteViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/24/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class FactorCompleteViewController: UIViewController, FactorListProtocol, MyFactorsProtocol {

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
    
    
    @IBAction func viewReport(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityScore") as! SelectivityViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    }
    
    
    // bring in factors
    var factorListItems: NSArray = NSArray()
    
    func factorsDownloaded(factors: NSArray) {
        factorListItems = factors
        
        print (factorListItems)
        
        let myFactors = MyFactorAnswers()
        myFactors.delegate = self
        myFactors.downloadMyFactorAnswers(userid: userId)
        
    }
    
    // download in myFactors
    var myFactors: NSArray = NSArray()
    
    func myFactorAnswersDownloaded(factors: NSArray) {
        myFactors = factors
        print (myFactors)
        
        var unlock = "yes"
        var factorCount = 0
        var answerCount = 0
        var selectivityCount = 0
        var unanswered: Array = [Int]()
        
        myFactors.forEach { myfa  in
            let thisAnswer = myfa as! MyFactorAnswersModel
            let answer = thisAnswer.answerId!
            let selectivity = thisAnswer.selectivity!
            
            if Int(answer) == 0 || Double(selectivity) == 0.50 {
                unlock = "no"
                unanswered.append(factorCount)
                answerCount += 1
            }
            
            factorCount += 1
            print (unlock)
        }
        
        if unlock == "yes" {
            // save to logs
            confirmBox.isHidden = false
            if (flexibilityCompleted == "") {
                updateUserLogs(userid: userId, item: "flexibility-completed")
            }
        }
        else {
            //confirmBox.isHidden = true
            let errorBox : UIScrollView = UIScrollView()
            
            errorBox.frame = CGRect(x: 20, y: 120, width: 350, height: 400)
            errorBox.backgroundColor = romLightGray
            
            background.addSubview(errorBox)
            
            errorBox.translatesAutoresizingMaskIntoConstraints = false
            
            errorBox.topAnchor.constraint(equalTo: background.topAnchor, constant: 120.0).isActive = true
            errorBox.centerXAnchor.constraint(equalTo: background.centerXAnchor, constant: 0.0).isActive = true
            errorBox.leadingAnchor.constraint(greaterThanOrEqualTo: background.leadingAnchor, constant: 10.0).isActive = true
            errorBox.trailingAnchor.constraint(greaterThanOrEqualTo: background.trailingAnchor, constant: 10.0).isActive = true
            errorBox.heightAnchor.constraint(greaterThanOrEqualToConstant: 400).isActive = true
            errorBox.widthAnchor.constraint(equalToConstant: 320).isActive = true
            
            
            let errorMessage: UILabel = UILabel()
            
            errorMessage.frame = CGRect(x: 10, y: 20, width: 300, height: 50)
            errorMessage.backgroundColor = UIColor.clear
            errorMessage.textAlignment = NSTextAlignment.center
            errorMessage.font = UIFont(name: "Trebuchet", size: 18)
            errorMessage.text = "You have \(answerCount) unanswered questions. Click to answer"
            errorMessage.numberOfLines = 0
            errorBox.addSubview(errorMessage)
            
            var labelPosition = 80
            
            unanswered.forEach { una in
                print (una)
                let factorLabel = UILabel()
                factorLabel.frame = CGRect(x: 10, y: labelPosition, width: 300, height: 30)
                factorLabel.backgroundColor = white
                factorLabel.textAlignment = NSTextAlignment.center
               
                
                let thisFactor = factorListItems[una] as! FactorListModel
                //print (thisFactor.name)
                factorLabel.text = "\(thisFactor.name!)"
                
                factorLabel.isUserInteractionEnabled = true
                
                
                let recognizer = FactorIconGestureRecognizer(target: self, action: #selector(self.iconTap), factorId: thisFactor.order!)
                
                factorLabel.addGestureRecognizer(recognizer)
                
                errorBox.addSubview(factorLabel)
                
                labelPosition = labelPosition + 40
            }
            errorBox.layoutIfNeeded()
        }
        
    }
    
    
    // view vars
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var confirmBox: UIView!
    
    @IBOutlet weak var congratsText: GradientLabel!
    
    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var viewReportButton: UIButton!
    
    var buttons = [UIButton]()
    
    @IBOutlet weak var retakeBkgd: UIButton!
    @IBOutlet weak var viewReportBkgd: UIButton!
    
    var bkgds = [UIButton]()
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmBox.isHidden = true
        
    
        let factorList = FactorList()
        factorList.delegate = self
        factorList.downloadItems()
        
        buttons.append(retakeButton)
        buttons.append(viewReportButton)
        
        congratsText.gradientColors = [romTeal.cgColor, romOrange.cgColor, romPink.cgColor]
        
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
    

    @objc func iconTap(gestureRecognizer: FactorIconGestureRecognizer)
    {
       
        print (gestureRecognizer.factorId)
        
        let fq = gestureRecognizer.factorId
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
        secondViewController.FQ = fq!
        
        //NewViewController create DisplayImg UIImageView object
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    class FactorIconGestureRecognizer : UITapGestureRecognizer {
        
        var factorId : Int?
        // any more custom variables here
        
        init(target: AnyObject?, action: Selector, factorId : Int) {
            super.init(target: target, action: action)
            
            self.factorId = factorId
        }
        
    }
   

}

