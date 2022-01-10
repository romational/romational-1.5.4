//
//  FactorViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 11/9/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

class FactorViewController: UIViewController, UITextFieldDelegate, FactorListProtocol, FactorQuestionProtocol, MyFactorsProtocol  {
    
    
    // MARK:  import question data
    
    // bring in factors
    var factorListItems: NSArray = NSArray()
    
    func factorsDownloaded(factors: NSArray) {
        factorListItems = factors
        
        //print (factors)
        
        let myFactors = MyFactorAnswers()
        myFactors.delegate = self
        myFactors.downloadMyFactorAnswers(userid: userId)
        
    }
    
    // bring in myFactors
    var myFactors: NSArray = NSArray()
    
    func myFactorAnswersDownloaded(factors: NSArray) {
        myFactors = factors
        //print (myFactors)
        
        let factorQuestions = FactorQuestionList()
        factorQuestions.delegate = self
        factorQuestions.downloadQuestions()
        
    }
    
    // bring in questions
    var factorQuestions: NSArray = NSArray()

    func questionsDownloaded(questions: NSArray) {
         
        factorQuestions = questions
         
        printFactorQuestions(fq : FQ)
         
        let questions = factorQuestions[FQIndex] as! FactorQuestionModel
        
        //factorQuestion.text = questions.info
        
    }
    

    
    // nav links
    
    @IBAction func allFactorsButton(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FQIntro") as! FQIntroViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
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
    
        slideController = (storyboard!.instantiateViewController(withIdentifier: "UserOptions") as! UserOptionsViewController)
           
            
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
    
    
    
    // back button
    
    @IBOutlet weak var goBackButton: UIButton!
    
    @IBAction func goBackClick(_ sender: Any) {
    
        
        if (goBack == "SelectivityAnalysis") {
        
            goBack = ""
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityAnalysis") as! SelectivityAnalysisViewController
            
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false, completion: nil)
         
        }
        
        if (goBack == "SelectivityRankings") {
        
            goBack = ""
         
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityRankings") 
            
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false, completion: nil)
            
        }
        
        if (goBack == "MyFactorData") {
        
            goBack = ""
         
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "MyFactorData") as! MyFactorDataViewController
            
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false, completion: nil)
            
        }
    
        if (goBack == "") {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "FQIntro") as! FQIntroViewController
        
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false, completion: nil)
        }
    }
    
    
    // MARK: ext prev buttons actions
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!


    @IBAction func nextQuestion(_ sender: UIButton) {
         
         // spinner
         self.showSpinner(onView: self.view)
        
         // clear this value to change
         factorOpt = 0
         
         // set FQ ahead by 1
         FQ = FQ + 1
         
        thisScrollView.scrollToTop()
        
         // clear boxes while await download
         answerBkgds.forEach { ck in
             //ck.backgroundColor = white
         }
         answerTexts.forEach { ckb in
            ckb.layer.borderColor = romDarkGray.cgColor
            ckb.layer.borderWidth = 0
            ckb.layer.cornerRadius = 10
            ckb.layer.backgroundColor = UIColor.clear.cgColor
            ckb.textContainerInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10);
            ckb.centerVertically()
         }
        
         answered = false
         pushed = false
        
         sliderBox.layer.borderWidth = 0.0
         sliderBox.backgroundColor = UIColor.clear
         
         if FQ > factorQuestions.count { let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
             let destination = storyboard.instantiateViewController(withIdentifier: "FactorComplete") as! FactorCompleteViewController
             destination.modalPresentationStyle = .fullScreen
             self.present(destination, animated: true)
         }
         else {
             let freshAnswers = MyFactorAnswers()
             freshAnswers.delegate = self
             freshAnswers.downloadMyFactorAnswers(userid: userId)
             
             //printFactorQuestions(fq : FQ)
         }
         
     }
     
     @IBAction func prevQuestion(_ sender: UIButton) {
         
         // spinner
         self.showSpinner(onView: self.view)
        
         // clear this value to change
         factorOpt = 0
         
         // set FQ behind 1
         FQ = FQ - 1
         
         thisScrollView.scrollToTop()
        
         // clear boxes while await download
         answerBkgds.forEach { ck in
             //ck.backgroundColor = white
         }
         answerTexts.forEach { ckb in
            ckb.layer.borderColor = romDarkGray.cgColor
            ckb.layer.borderWidth = 0
            ckb.layer.cornerRadius = 10
            ckb.layer.backgroundColor = UIColor.clear.cgColor
            ckb.textContainerInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10);
            ckb.centerVertically()
         }
         
         // reset the  prev nex
         answered = false
         pushed = false
         
         // reset the slider box
         sliderBox.layer.borderWidth = 0.0
         sliderBox.backgroundColor = UIColor.clear
         
         // bring in answers fresh
         let freshAnswers = MyFactorAnswers()
         freshAnswers.delegate = self
         freshAnswers.downloadMyFactorAnswers(userid: userId)
         
         //printFactorQuestions(fq : FQ)
     }
    
    
    // MARK: question vars
    
    var ThisFactor = String()
    var FQ = Int()
    var FQIndex = Int()
    var QID = Int()
    var currentSelectivity = Float()
    
    var answered = false
    var pushed = false
    
    // MARK: question info
    
    @IBOutlet weak var thisScrollView: UIScrollView!
    @IBOutlet var factorView: UIView!
    
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var factorTitle: UILabel!
    @IBOutlet weak var factorImage: UIImageView!
    @IBOutlet weak var factorQuestion: UILabel!
    
   
    @IBAction func factorInfo(_ sender: Any) {
        let questions = factorQuestions[FQIndex] as! FactorQuestionModel
        
        let message = questions.info
        let alertController:UIAlertController = UIAlertController(title: "About this Factor", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK, Got It!", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    
    }
    
    
    // MARK: answer checkboxes
    
    // answer views
    @IBOutlet weak var A1View: UIView!
    @IBOutlet weak var A2View: UIView!
    @IBOutlet weak var A3View: UIView!
    @IBOutlet weak var A4View: UIView!
    @IBOutlet weak var A5View: UIView!
    
    var answerBkgds = [UIView]()
    
    
    // checkbox label answers
    @IBOutlet weak var A1text: UITextView!
    @IBOutlet weak var A2text: UITextView!
    @IBOutlet weak var A3text: UITextView!
    @IBOutlet weak var A4text: UITextView!
    @IBOutlet weak var A5text: UITextView!
  
    var answerTexts = [UITextView]()
    
    
    @IBOutlet weak var radio1: UIImageView!
    @IBOutlet weak var radio2: UIImageView!
    @IBOutlet weak var radio3: UIImageView!
    @IBOutlet weak var radio4: UIImageView!
    @IBOutlet weak var radio5: UIImageView!
    
    var radios      = [UIImageView]()
    
    
    // MARK: slider box
    
    @IBOutlet weak var sliderBox: UIView!

    @IBOutlet weak var flexibilityLabel: UILabel!
    @IBOutlet weak var unimportant: UILabel!
    @IBOutlet weak var dealbreaker: UILabel!

    @IBOutlet weak var importanceSlider: GradientSlider!
    @IBOutlet weak var sliderValue: UITextField!
    
    @IBAction func sliderDot(_ sender: Any) {

       // adjust the slider
        adjustSlider(selectivity: importanceSlider.value)
       
       //let rank = round(importanceSlider.value * 100)
       
    }
   
    // slider labels

    
    var sliderLabels = [UILabel]()
    
   // slider button labels
    @IBOutlet weak var sliderLabel1: UILabel!
    @IBOutlet weak var sliderLabel2: UILabel!
    @IBOutlet weak var sliderLabel3: UILabel!
    @IBOutlet weak var sliderLabel4: UILabel!
    @IBOutlet weak var sliderLabel5: UILabel!
    
    
    // MARK: view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // save to logs
        print ("factors started? \(flexibilityStarted)")
        if (flexibilityStarted == "") {
            updateUserLogs(userid: userId, item: "flexibility-started")
        }
        
        self.showSpinner(onView: self.view)
        
        // create button arrays
        answerBkgds.append(A1View)
        answerBkgds.append(A2View)
        answerBkgds.append(A3View)
        answerBkgds.append(A4View)
        answerBkgds.append(A5View)
        
        answerTexts.append(A1text)
        answerTexts.append(A2text)
        answerTexts.append(A3text)
        answerTexts.append(A4text)
        answerTexts.append(A5text)
        
        radios.append(radio1)
        radios.append(radio2)
        radios.append(radio3)
        radios.append(radio4)
        radios.append(radio5)
        
        sliderLabels.append(sliderLabel1)
        sliderLabels.append(sliderLabel2)
        sliderLabels.append(sliderLabel3)
        sliderLabels.append(sliderLabel4)
        sliderLabels.append(sliderLabel5)
        
        // round the corners to make button
        sliderLabels.forEach { slide in
            slide.layer.cornerRadius = 8
            slide.layer.masksToBounds = true
        }
        
        //round box so it doesn't jar so much
        sliderBox.layer.cornerRadius = 10
        sliderBox.layer.masksToBounds = true
        
        
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
            
            let font = UIFont(name: "HelveticaNeue", size: 10)!
            
            let rangeName = thisRange!["name"] as? String
       
            sliderLabels[i].text = rangeName!
            
            let tap = MyTapGesture(target: self, action: #selector(tapped))

            let ranking = thisRange!["ranking"] as? String
            //print (ranking)
            
            tap.ranking = ranking!
            tap.numberOfTapsRequired = 1

            if i == 0 {
                tap.color = "teal"
            }
            if i == 1 {
                tap.color = "green"
            }
            if i == 2 {
                tap.color = "yellow"
            }
            if i == 3 {
                tap.color = "orange"
            }
            if i == 4 {
                tap.color = "pink"
            }
            
            sliderLabels[i].addGestureRecognizer(tap)
            sliderLabels[i].isUserInteractionEnabled = true

        }
        
        // import factor data
        let factorList = FactorList()
        factorList.delegate = self
        factorList.downloadItems()
        
        
        // setup slider
        sliderBox.backgroundColor = UIColor.clear
        
        sliderValue.delegate = self
        //sliderValue.keyboardType = .numberPad
        
        importanceSlider.thumbTintColor = yellow
        //importanceSlider.value = 0.50
        importanceSlider.value = 0.0
        importanceSlider.addTarget(self, action:#selector(sliderDidEndSliding), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        // put ring around the slider value text
        sliderValue.layer.cornerRadius = 15
        sliderValue.layer.borderWidth = 1
        
        // return links
        //print (goBack)
        
        goBackButton.layer.cornerRadius = 20
        goBackButton.layer.masksToBounds = false
        goBackButton.layer.shadowColor = romDarkGray.cgColor
        goBackButton.layer.shadowOpacity = 0.3
        goBackButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        goBackButton.layer.shadowRadius = 4
        
        if (goBack == "SelectivityAnalysis") || (goBack == "SelectivityRankings") || (goBack == "MyFactorData") {
            goBackButton.isHidden = false
            if (goBack == "SelectivityAnalysis") {
                goBackButton.setTitle("Back to FlexScore Report", for: .normal)
            }
            if (goBack == "SelectivityRankings") {
                goBackButton.setTitle("Back to FlexScore Report", for: .normal)
            }
            if (goBack == "MyFactorData") {
                goBackButton.setTitle("Back to FlexScore Answers ", for: .normal)
            }
        }
        else {
            goBackButton.isHidden = true
            
        }
        
        
    }
    
    func viewWillAppear() {
        
        self.view.layoutIfNeeded()
        
    }

    
    // MARK:  TextFields
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // resign keyboard on return
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // scroll to box for editing
        
        let point = self.sliderBox.frame.origin
        
        DispatchQueue.main.async {
            
            self.thisScrollView.contentOffset = CGPoint(x: 0, y: point.y)
        }
        
        //print (point)
        
        // highlight colors
        textField.backgroundColor = romLightGray
       
        textField.layer.borderColor = romDarkGray.cgColor
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 20
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // default color
        textField.layer.borderWidth = 1
        
        //textField.addBottomBorder(height: 1, color: romDarkGray)
        textField.backgroundColor = UIColor.clear
        textField.layer.cornerRadius = 20
        
        guard let selectivity = textField.text else {
           
            return
        }
        
        print (selectivity)
        
        // ** stilll need to allow for decimal (float) entries **!!
        let newSelectivity = Float(Int(selectivity)!) / 100
        
        //print ("TextField Edited: \(newSelectivity)")
        
        // make updates to slider and storage
        importanceSlider.value = newSelectivity
        
        updateSelectivity(userid: userId, factor: String(QID), selectivity: newSelectivity)
        
        adjustSlider(selectivity: newSelectivity)
        
        // update button enabled
        if (answered == true) {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
        
        // clear label border
        sliderLabels.forEach { label in
            label.layer.borderWidth = 0
        }
        
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
            let rangeName = thisRange!["name"] as? String
            let lowRange  = Float((thisRange!["low"] as? String)!)! / 100.0
            let highRange = Float((thisRange!["high"] as? String)!)! / 100.0
            
            if newSelectivity > lowRange && newSelectivity <= highRange  {
                
                //flexibilityLabel.text = rangeName!
                
                if i == 0 {
                    sliderLabels[0].layer.borderWidth = 2
                    sliderLabels[0].layer.borderColor = romDarkGray.cgColor
                  
                    importanceSlider.thumbTintColor = romTeal
                    importanceSlider.minimumTrackTintColor = romTeal
                    sliderValue.layer.borderColor = romTeal.cgColor
                }
                if i == 1 {
                    sliderLabels[1].layer.borderWidth = 2
                    sliderLabels[1].layer.borderColor = romDarkGray.cgColor
                    importanceSlider.thumbTintColor = green
                    importanceSlider.minimumTrackTintColor = green
                    sliderValue.layer.borderColor = green.cgColor
                }
                if i == 2 {
                    sliderLabels[2].layer.borderWidth = 2
                    sliderLabels[2].layer.borderColor = romDarkGray.cgColor
                    importanceSlider.thumbTintColor = yellow
                    importanceSlider.minimumTrackTintColor = yellow
                    sliderValue.layer.borderColor = yellow.cgColor
                }
                if i == 3 {
                    sliderLabels[3].layer.borderWidth = 2
                    sliderLabels[3].layer.borderColor = romDarkGray.cgColor
                    importanceSlider.thumbTintColor = romOrange
                    importanceSlider.minimumTrackTintColor = romOrange
                    sliderValue.layer.borderColor = romOrange.cgColor
                }
                if i == 4 {
                    sliderLabels[4].layer.borderWidth = 2
                    sliderLabels[4].layer.borderColor = romDarkGray.cgColor
                    importanceSlider.thumbTintColor = romPink
                    importanceSlider.minimumTrackTintColor = romPink
                    sliderValue.layer.borderColor = romPink.cgColor
                }
                
            }
                
        }
        
        
        
    }
    
    /*
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        }
    */
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // check decimal restriction
        let replacementStringIsLegal = string.rangeOfCharacter(from: CharacterSet(charactersIn:"0123456789").inverted ) == nil

        if !replacementStringIsLegal {
            return false
        }
        let nsString = textField.text as NSString?
        let newString = nsString!.replacingCharacters(in: range, with: string)

        // check maximum length
        if newString.count > 2 {
            return false
        }
        return true

    }
    
        
    // =======================================================
    //                  IN VIEW FUNCTIONS
    // =======================================================

    
    // these variables are for the popup overlay before question is displayed
    var beforeView = UIView()
    
    var beforeTitle = UILabel()
    var beforeTextView = UITextView()
    var logoView = UIImageView()
    
    
    // MARK: question answer functions
    
    // create factor questions
    func printFactorQuestions(fq : Int) {
        
        /*checkviews.forEach { ck in
            ck.layer.borderColor = medgray.cgColor
            ck.layer.borderWidth = 0.5
        }*/
        
        // style out the checkboxes
        answerTexts.forEach { ckb in
            ckb.layer.borderColor = romDarkGray.cgColor
            ckb.layer.borderWidth = 0
            ckb.layer.cornerRadius = 10
            ckb.layer.backgroundColor = UIColor.clear.cgColor
            ckb.textContainerInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10);
            ckb.centerVertically()
            ckb.font = UIFont(name:"HelveticaNeue", size: 16.0)
        }
        
        //clear out the slider label highlight
        sliderLabels.forEach { label in
            label.layer.borderWidth = 0
        }
        
        //let offImage = UIImage(named: "radio-button-off-200x200.png") as UIImage?
        
        // reset radio button images
        radios.forEach { radio in
            radio.image = UIImage(named:  "radio-button-off-200x200.png")
            
        }
        
        let totalQs = factorListItems.count
        //print ("there are \(totalQs) questions")
        
        // factor opt global comes from next prev
        if factorOpt != 0 {
            
            FQ = factorOpt
        }
        // default factors intro setting
        else if fq == 0 {
                   
            FQ = myFactors.count
            //print ("FQ is \(FQ)")
            
            // if no stored factors set question to 1
            if FQ == 0 {
                FQ = 1
            }
            // else check my stored factors to get first missing FQ
            else {
               
                for i in 0..<myFactors.count {
                    
                    FQ = i + 1
                    
                    let myFactor = myFactors[i] as! MyFactorAnswersModel
                    
                    // it is only 0 if no results for answer in array
                    if Int(myFactor.answerId!)! == 0 {
                        
                        //FQ =  Int(myFactor.factorId!)!
                                           
                   
                        break
                        
                    }
                    else {
                   
                        
                    }
                    //print ("FQ is \(FQ)")
                    
                }
            }
        }
        // if fq is set then make FQ that question
        else {
            FQ = fq
        
        }
        
        FQIndex = FQ - 1
        
       // print ("\(totalQs) Questions - fq is \(fq) - FQ is \(FQ) - FQIndex is \(FQIndex)")
        
        
        var questions = FactorQuestionModel()
        
        // ** need to limit out of bounds on this **
        if FQ <= factorQuestions.count {
            
            questions = factorQuestions[FQIndex] as! FactorQuestionModel
            
            QID = questions.id!
            let qId = questions.id!
            let qName = questions.name!.uppercased()
            //let qOrder = questions.order!
            //let qQuestion = questions.question!
            
            // yes I used this old variable to bring in a title 12.1.21
            var beforeTitleImage = questions.beforeImage ?? "romational-icon-v4"
            if beforeTitleImage == "" {
                beforeTitleImage = "romational-icon-v4"
            }
            
            
            var beforeTitleText = questions.beforeTitle ?? "Did You Know?"
            if beforeTitleText == "" {
                beforeTitleText = "Did You Know?"
            }
            
            let beforeText = questions.beforeText!
            
            var beforeButton = questions.beforeButton ?? "OK"
            if beforeButton == "" {
                beforeButton = "OK"
            }
            
            //print (beforeText)
           
            
            if beforeText != "" {
                
                self.beforeView.isHidden = false
                
                let vcWidth   = view.bounds.width
                let vcHeight = view.bounds.height
                
                let navHeight = navBar.frame.height
                
                // moved outside function for access by objc func for button
                //var myView = UIView(frame: CGRect(x: 0, y: 0, width: vcWidth, height: vcHeight))
                
                beforeView.frame = CGRect(x: vcWidth, y: 100, width: vcWidth, height: vcHeight)
                beforeView.backgroundColor = romBkgd
                beforeView.alpha = 0.0
                
                // logo
                //var logoView : UIImageView
                logoView  = UIImageView(frame: CGRect(x: ((vcWidth-320)/2)+80, y: 100, width: 160, height: 160));
                logoView.image = UIImage(named: beforeTitleImage)
               
                beforeView.addSubview(logoView)
                
                // before title
              
                beforeTitle.frame = CGRect(x: 30, y: 300, width: vcWidth-60, height: 30)
                
                beforeTitle.layer.backgroundColor = UIColor.clear.cgColor
                beforeTitle.text = beforeTitleText
                beforeTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 24.0)
                beforeTitle.textColor = romDarkGray
                beforeTitle.textAlignment = .center
                
                beforeView.addSubview(beforeTitle)
                
                // before text
                //let beforeTextView = UITextView(frame: CGRect(x: 30, y: 400, width: vcWidth-60, height: 200))
                beforeTextView.frame = CGRect(x: 30, y: 350, width: vcWidth-60, height: 120)
                beforeTextView.centerVertically()
                beforeTextView.backgroundColor = .clear
                beforeTextView.text = beforeText
                beforeTextView.font = UIFont(name:"HelveticaNeue", size: 18.0)
                beforeTextView.textColor = romDarkGray
                beforeTextView.textAlignment = .center
                
                beforeView.addSubview(beforeTextView)
                
                // before text
                let beforeTextOK = UIButton(frame: CGRect(x: 60, y: 500, width: vcWidth-120, height: 60))
                beforeTextOK.setTitle(beforeButton, for: .normal)
                beforeTextOK.addTarget(self, action: "okButtonClicked:", for: .touchUpInside)
                beforeTextOK.setTitleColor(romRed, for: .normal)
                beforeTextOK.backgroundColor = romBkgd

                beforeTextOK.layer.masksToBounds = false
                beforeTextOK.layer.shadowColor = romDarkGray.cgColor
                beforeTextOK.layer.shadowOpacity = 0.3
                beforeTextOK.layer.shadowOffset = CGSize(width: 4, height: 4)
                beforeTextOK.layer.shadowRadius = 4
            
                beforeTextOK.layer.cornerRadius = 30
                
                
                beforeView.addSubview(beforeTextOK)
                
                view.addSubview(beforeView)
                UIView.animate(withDuration: 0.25) { () -> Void in
                    self.beforeView.alpha = 1.0
                    self.beforeView.frame = CGRect(x: 0, y: 100, width: vcWidth, height: vcHeight-100)
                }
                
                
            }
            
            
            //let qImage = questions.image!
            
            // load up the question
            questionNumber.text = ("Question \(FQ) of \(totalQs)")
            factorTitle.text = qName
            //factorImage.image  = UIImage(named: qImage)
            //factorQuestion.text = (" \(qQuestion)")
            
            // set the tap gesture
            func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
                return true
            }
            
            
            var answer = 0
            
            // check for results to avoid crash
            if myFactors.count != 0 {
                
                //print ("ok")
              
                if (myFactors).count > FQIndex {
                  
                    let factorAnswer = myFactors[FQIndex] as! MyFactorAnswersModel
                 
                    
                    if qId == Int(factorAnswer.factorId!)! {
                        
                        answer = 0
                        if factorAnswer.answerId! != "" {
                            answer = Int(factorAnswer.answerId!)!
                        }
                        var selectivityDouble = 0.0
                        print ("flex is \(factorAnswer.selectivity!)")
                        
                        selectivityDouble = Double(factorAnswer.selectivity!)!
                        
                        // reset to 0 teal color
                        importanceSlider.thumbTintColor = romTeal
                        
                        importanceSlider.value = Float(selectivityDouble)
                       //print (factorAnswer.selectivity)
                        
                        if (factorAnswer.selectivity != nil) {
                            
                            let flexibilityRanking = Int(selectivityDouble * 100)
                            
                            pushed = true

                            //print ("ranges here")
                            for i in 0..<Ranges.count {
                                
                                let thisRange = Ranges[i] as? NSDictionary
                                
                                //print (thisRange!["low"]!)
                                let rangeName = thisRange!["name"] as? String
                                let lowRange  = thisRange!["low"] as? String
                                let highRange = thisRange!["high"] as? String
                                
                                //print ("\(rangeName) \(lowRange) \(highRange)")
                            
                                // high light the active
                                if flexibilityRanking > Int(lowRange!)! && flexibilityRanking <= Int(highRange!)!  {
                                    
                                    //flexibilityLabel.text = rangeName!
                                    sliderLabels[i].layer.borderWidth = 2
                                    sliderLabels[i].layer.borderColor = romDarkGray.cgColor
                                    
                                    
                                }
                                    
                            }
                        }
                        // take out the .50 changed to button defaults 12.8.21
                       /*if (importanceSlider.value == 0.50) && (answer != 0) {
                       
                               
                            answered = true
                            
                            nextButton.isEnabled = false
                            prevButton.isEnabled = false
       
                            sliderBox.layer.borderWidth = 1.0
                            sliderBox.layer.borderColor = yellow.cgColor
                                
                                
                            sliderBox.backgroundColor = graphgray
                        }
                        */
                        
                        
                        // configure the slider
                        adjustSlider(selectivity: importanceSlider.value)
                    }
                }
                
            }
        
            // now the answers
            let qAnswers = questions.answers
            let totalAnswers = qAnswers?.count
            
            // show hide based on answers number
            if Int(totalAnswers!) == 5 {
                answerBkgds.forEach { cv in
                    cv.isHidden = false
                }
            }
            if Int(totalAnswers!) < 5 {
                answerBkgds[4].isHidden = true
            }
            if Int(totalAnswers!) < 4 {
                answerBkgds[3].isHidden = true
            }
            if Int(totalAnswers!) < 3 {
                answerBkgds[2].isHidden = true
            }
            
            if Int(totalAnswers!) > 0 {
                
                
                // no answer selected
                if (answer == 0 ) {
                    nextButton.isEnabled = false
                    //prevButton.isEnabled = false
                    
                    /*
                    checkviews.forEach { ck in
                        ck.layer.borderColor = coolblue.cgColor
                        ck.layer.borderWidth = 2.0
                    }
                    
                    nextButton.backgroundColor = coolblue
                    prevButton.backgroundColor = coolblue
                    */
                }
                
                for i in 0...totalAnswers! - 1 {
                    
                    // check if more answers than checkboxes
                    if answerTexts.count >  i {
                        
                        let answerId = answerTexts[i]
                        
                        let qAnswer = qAnswers?[i] as? [String:Any]
                       
                        let thisAnswer = qAnswer?["factorAnswer_text"] as? String
                        let thisAnswerVal = qAnswer?["factorAnswer_id"] as? String ?? "0"
                        
                        answerId.text = ("\(thisAnswer!)")
                        answerId.centerVertically()
                        
                        if Int(thisAnswerVal) == answer && Int(thisAnswerVal) != 0 {
                            
                            answered = true
                            
                            answerTexts[i].layer.borderWidth = 0
                            answerTexts[i].layer.borderColor = romDarkGray.cgColor
                            //answerTexts[i].layer.backgroundColor = romLightGray.cgColor
                            radios[i].image = UIImage(named:  "radio-button-on-200x200.png")
                      
                            answerTexts[i].font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
                        }
                        else {
                            //answerBkgds[i].backgroundColor = white
                            //checkboxes[i].backgroundColor = white
                            //checkimages[i].image  = UIImage(named: "bar-button-unchecked")
                        }
                        
                        // setup the tap
                        let tap = MyTapGesture(target: self, action: #selector(FactorViewController.tappedMe))
                        answerTexts[i].addGestureRecognizer(tap)
                        answerTexts[i].isUserInteractionEnabled = true
                        
                        tap.title = "A\(i+1)"
                        tap.value = Int(thisAnswerVal)!
                        tap.fq = qId
                        tap.sel = currentSelectivity
                        
                        
                        let tap2 = MyTapGesture(target: self, action: #selector(FactorViewController.tappedMe))
                        radios[i].addGestureRecognizer(tap2)
                        radios[i].isUserInteractionEnabled = true
                     
                        tap2.title = "A\(i+1)"
                        tap2.value = Int(thisAnswerVal)!
                        tap2.fq = qId
                        tap2.sel = currentSelectivity
                    }
                }
            }
            
            // no answers for question yet
            else {
                // clear out the answer labels using closure
                answerTexts.forEach { ck in
                    ck.text = ""
                }//
                
            }
        
        }
        // next is out of bounds (go to report?
        else {
            FQ = factorQuestions.count
        }
        
        self.removeSpinner()
        
    }
    
    
        
    // adjust the slider
    func adjustSlider(selectivity: Float) {
        
        // set global for updating
        currentSelectivity = selectivity
        
        print ("Adjust Slider: \(selectivity)")
        
        
        sliderValue.text = String(Int(round(selectivity * 100)))
        
        //print(sliderValue.text)
        
        //print ("ranges here")
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
            let rangeName = thisRange!["name"] as? String
            let lowRange  = Float((thisRange!["low"] as? String)!)! / 100.0
            let highRange = Float((thisRange!["high"] as? String)!)! / 100.0
            
            if selectivity > lowRange && selectivity <= highRange  {
                
                //flexibilityLabel.text = rangeName!
                
                if i == 0 {
                    importanceSlider.thumbTintColor = romTeal
                    importanceSlider.minimumTrackTintColor = romTeal
                    sliderValue.layer.borderColor = romTeal.cgColor
                }
                if i == 1 {
                    importanceSlider.thumbTintColor = green
                    importanceSlider.minimumTrackTintColor = green
                    sliderValue.layer.borderColor = green.cgColor
                }
                if i == 2 {
                    importanceSlider.thumbTintColor = yellow
                    importanceSlider.minimumTrackTintColor = yellow
                    sliderValue.layer.borderColor = yellow.cgColor
                }
                if i == 3 {
                    importanceSlider.thumbTintColor = romOrange
                    importanceSlider.minimumTrackTintColor = romOrange
                    sliderValue.layer.borderColor = romOrange.cgColor
                }
                if i == 4 {
                    importanceSlider.thumbTintColor = romPink
                    importanceSlider.minimumTrackTintColor = romPink
                    sliderValue.layer.borderColor = romPink.cgColor
                }
                
            }
                
        }
        
        
        
    }
    
    
    // updating info
    func updateSelectivity(userid: String, factor: String, selectivity: Float){
           
       // post(parameters: [userid, factor, String(selectivity)], urlString: "http://romadmin.com/updateSelectivity.php")
        //post(parameters: [userid, factor, String(selectivity)], urlString: "https://romdat.com/user/\(userid)/selectivity/update")
       // print(selectivity)
        print ("Update Selectivity: \(selectivity)")
        
        postWithCompletion(parameters:  [userid, factor, String(selectivity)], urlString: "https://romdat.com/user/\(userid)/selectivity/update") { success, result in
            
                print (result)
        }
    }
       
    
 
    
    
    // saving answers
    
    func saveFactorAnswer(userid: String, factor: String, answer: String, selectivity: Float){
           
        //post(parameters: [userid, factor, answer, String(selectivity)], urlString: "https://romdat.com/user/\(userid)/factors/update")
        postWithCompletion(parameters:  [userid, factor, answer, String(selectivity)], urlString: "https://romdat.com/user/\(userid)/factors/update") { success, result in
            
                print (result)
        }
        
    }
       
    // ok button on before text display
    @objc func okButtonClicked(_ sender: AnyObject?) {
        
        
        let vcWidth   = self.view.bounds.width
        let vcHeight = self.view.bounds.height
        
        
        UIView.animate(withDuration: 0.25) { () -> Void in
            self.beforeView.alpha = 0.0
            self.beforeView.frame = CGRect(x: -vcWidth, y: 100, width: vcWidth, height: vcHeight-100)
            self.beforeView.isHidden = true
        }
        
        
        self.beforeTextView.text = ""
        
    }
    
    
    // when a flexibility button is chosen (tapped)
    @objc func tapped(sender : MyTapGesture) {

        pushed = true
        
        if (answered == true) && (pushed == true) {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
        
        self.sliderValue.text = sender.ranking
        self.importanceSlider.value = Float(Int(sender.ranking)!) / 100.0
        
        //clear out the slider label highlight
        sliderLabels.forEach { label in
            label.layer.borderWidth = 0
        }
        
        updateSelectivity(userid: userId, factor: String(QID), selectivity: importanceSlider.value)
        
        if sender.color == "teal" {
            //clear out the slider label highlight
          
            sliderLabels[0].layer.borderWidth = 2
            sliderLabels[0].layer.borderColor = romDarkGray.cgColor
            importanceSlider.thumbTintColor = romTeal
            importanceSlider.minimumTrackTintColor = romTeal
            sliderValue.layer.borderColor = romTeal.cgColor
        }
        if sender.color == "green" {
            sliderLabels[1].layer.borderWidth = 2
            sliderLabels[1].layer.borderColor = romDarkGray.cgColor
            importanceSlider.thumbTintColor = green
            importanceSlider.minimumTrackTintColor = green
            sliderValue.layer.borderColor = green.cgColor
        }
        if sender.color == "yellow" {
            sliderLabels[2].layer.borderWidth = 2
            sliderLabels[2].layer.borderColor = romDarkGray.cgColor
            importanceSlider.thumbTintColor = yellow
            importanceSlider.minimumTrackTintColor = yellow
            sliderValue.layer.borderColor = yellow.cgColor
        }
        if sender.color == "orange" {
            sliderLabels[3].layer.borderWidth = 2
            sliderLabels[3].layer.borderColor = romDarkGray.cgColor
            importanceSlider.thumbTintColor = romOrange
            importanceSlider.minimumTrackTintColor = romOrange
            sliderValue.layer.borderColor = romOrange.cgColor
        }
        if sender.color == "pink" {
            sliderLabels[4].layer.borderWidth = 2
            sliderLabels[4].layer.borderColor = romDarkGray.cgColor
            importanceSlider.thumbTintColor = romPink
            importanceSlider.minimumTrackTintColor = romPink
            sliderValue.layer.borderColor = romPink.cgColor
        }
        
    }
    
    
    // when slider is moved
    @objc func sliderDidEndSliding() {
        
        print ("end sliding")
        
        updateSelectivity(userid: userId, factor: String(QID), selectivity: importanceSlider.value)
        
        print ("\(importanceSlider.value) %")
        
        pushed = true
        
        if (answered == true) && (pushed == true ) {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
        //nextButton.backgroundColor = UIColor.clear
        //prevButton.backgroundColor = UIColor.clear
        
        //clear out the slider label highlight
        sliderLabels.forEach { label in
            label.layer.borderWidth = 0
        }
        
        // cycle the ranges for the current
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            let lowRange  = Float((thisRange!["low"] as? String)!)! / 100.0
            let highRange = Float((thisRange!["high"] as? String)!)! / 100.0
            
 
            if importanceSlider.value > lowRange && importanceSlider.value <= highRange  {
                
                //flexibilityLabel.text = rangeName!
                
                sliderLabels[i].layer.borderWidth = 2
                sliderLabels[i].layer.borderColor = romDarkGray.cgColor
                
            }
        }
            
    }
    
    
    // when a question is chosen (tapped)
    @objc func tappedMe(sender : MyTapGesture) {

        answered = true
        
        if (answered == true) && (pushed == true) {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
        
        // if not answered and pushed highlight the box
        else {
            
            sliderBox.layer.borderWidth = 1.0
            sliderBox.layer.borderColor = medgray.cgColor
            sliderBox.backgroundColor =  graphgray
            
            //nextButton.backgroundColor = yellow
            //prevButton.backgroundColor = yellow
 
            
        }
        
    
        // clear out button styles
        answerTexts.forEach { ck in
     
            ck.backgroundColor = UIColor.clear
            ck.layer.borderWidth = 0.0
            ck.layer.borderColor = romDarkGray.cgColor
            ck.font = UIFont(name:"HelveticaNeue", size: 16.0)
            ck.textContainerInset = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10);
            ck.centerVertically()
       
        }
        
        radios.forEach { radio in
            radio.image = UIImage(named:"radio-button-off-200x200.png")
        }
       
        //print(sender.title)
        //print(sender.value)
        
        
        if (sender.title == "A1") {
            //A1text.layer.backgroundColor = romLightGray.cgColor
            A1text.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            A1text.layer.borderWidth = 0.0
            radio1.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A2") {
            //A2text.layer.backgroundColor = romLightGray.cgColor
            A2text.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            A2text.layer.borderWidth = 0.0
            radio2.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A3") {
            //A3text.layer.backgroundColor = romLightGray.cgColor
            A3text.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            A3text.layer.borderWidth = 0.0
            radio3.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A4") {
            //A4text.layer.backgroundColor = romLightGray.cgColor
            A4text.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            A4text.layer.borderWidth = 0.0
            radio4.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A5") {
            //A5text.layer.backgroundColor = romLightGray.cgColor
            A5text.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            A5text.layer.borderWidth = 0.0
            radio5.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        
        
    }
    
    
   // button clicks
    
    func didSelectButton(selectedButton: UIButton?) {
        let defaults = UserDefaults.standard
        //print(" \(selectedButton!.tag)" )
        let fqRank = ("R\(FQ)")
        defaults.set(selectedButton!.tag, forKey: fqRank)
    }
  
    
    
    // MARK: custom UI classes
    
    class CustomSlider : UISlider {
        override func trackRect(forBounds bounds: CGRect) -> CGRect {
            let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 20.0))
            super.trackRect(forBounds: customBounds)
            return customBounds
         
        }
    }
    
    class MyTapGesture: UITapGestureRecognizer {
        var title = String()
        var value = Int()
        var fq = Int()
        var sel = Float()
        var ranking = String()
        var color = String()
    }


}

