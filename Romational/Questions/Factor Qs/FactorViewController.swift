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
            let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityRankings") as! UIViewController
            
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
            ckb.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
            ckb.centerVertically()
         }
         
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
            ckb.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
            ckb.centerVertically()
         }
         
         sliderBox.layer.borderWidth = 0.0
         sliderBox.backgroundColor = UIColor.clear
         
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
    @IBOutlet weak var sliderLabel1: UILabel!
    @IBOutlet weak var sliderLabel2: UILabel!
    @IBOutlet weak var sliderLabel3: UILabel!
    @IBOutlet weak var sliderLabel4: UILabel!
    @IBOutlet weak var sliderLabel5: UILabel!
    
    var sliderLabels = [UILabel]()
    
    
    // MARK: view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // save to logs
        print ("factors started? \(flexibilityStarted)")
        if (flexibilityStarted == "") {
            updateUserLogs(userid: userId, item: "flexibility-started")
        }
        
        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        
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
        
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
            let rangeName = thisRange!["name"] as? String
            sliderLabels[i].text = rangeName!
        }
        
        // import factor data
        let factorList = FactorList()
        factorList.delegate = self
        factorList.downloadItems()
        
        
        // setup slider
        sliderBox.backgroundColor = UIColor.clear
        
        sliderValue.delegate = self
        
        importanceSlider.thumbTintColor = yellow
        importanceSlider.value = 0.50
        importanceSlider.addTarget(self, action:#selector(sliderDidEndSliding), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        
        // put ring around the slider value text
        sliderValue.layer.cornerRadius = 15
        sliderValue.layer.borderWidth = 1
        
        // return links
        print (goBack)
        
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

    
    // MARK: question answer functions
    
    // create factor questions
    func printFactorQuestions(fq : Int) {
        
        /*checkviews.forEach { ck in
            ck.layer.borderColor = medgray.cgColor
            ck.layer.borderWidth = 0.5
        }*/
        
        answerTexts.forEach { ckb in
            ckb.layer.borderColor = romDarkGray.cgColor
            ckb.layer.borderWidth = 0
            ckb.layer.cornerRadius = 10
            ckb.layer.backgroundColor = UIColor.clear.cgColor
            ckb.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
            ckb.centerVertically()
            ckb.font = UIFont(name:"HelveticaNeue", size: 17.0)
        }
        
        //let offImage = UIImage(named: "radio-button-off-200x200.png") as UIImage?
        
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
        
        print ("\(totalQs) Questions - fq is \(fq) - FQ is \(FQ) - FQIndex is \(FQIndex)")
        
        
        var questions = FactorQuestionModel()
        
        // ** need to limit out of bounds on this **
        if FQ <= factorQuestions.count {
            
            questions = factorQuestions[FQIndex] as! FactorQuestionModel
            
            QID = questions.id!
            let qId = questions.id!
            let qName = questions.name!.uppercased()
            let qOrder = questions.order!
            let qQuestion = questions.question!
            let qImage = questions.image!
            
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
                        var selectivityDouble = 0.50
                        print ("flex is \(factorAnswer.selectivity!)")
                        
                        selectivityDouble = Double(factorAnswer.selectivity!)!
                        
                        // reset to 0 teal color
                        importanceSlider.thumbTintColor = romTeal
                        
                        importanceSlider.value = Float(selectivityDouble)
                        
                        if (importanceSlider.value == 0.50) && (answer != 0) {
                           
                            answered = true
                            
                            nextButton.isEnabled = false
                            prevButton.isEnabled = false
       
                            sliderBox.layer.borderWidth = 1.0
                            sliderBox.layer.borderColor = yellow.cgColor
                                
                                
                            sliderBox.backgroundColor = graphgray
                        }
                        
                        // configure the slider
                        adjustSlider(selectivity: importanceSlider.value)
                    }
                }
                
            }
        
            // now the answers
            let qAnswers = questions.answers as? Array<Any>
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
                let qAnswer = qAnswers?[0] as? [String:Any]
                
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
    
    
    // when slider is moved
    @objc func sliderDidEndSliding() {
        
        print ("end sliding")
        
        updateSelectivity(userid: userId, factor: String(QID), selectivity: importanceSlider.value)
        
        print ("\(importanceSlider.value) %")
        
        if (answered == true) {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
        //nextButton.backgroundColor = UIColor.clear
        //prevButton.backgroundColor = UIColor.clear
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
            
            print ("\(rangeName) \(lowRange) \(highRange)")
        
            
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
        
        
        print (point)
        
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
        
        print ("TextField Edited: \(newSelectivity)")
        
        // make updates to slider and storage
        importanceSlider.value = newSelectivity
        
        updateSelectivity(userid: userId, factor: String(QID), selectivity: newSelectivity)
        
        adjustSlider(selectivity: newSelectivity)
        
    
        if (answered == true) {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
        
        
    }
    
    
    // saving answers
    
    func saveFactorAnswer(userid: String, factor: String, answer: String, selectivity: Float){
           
        //post(parameters: [userid, factor, answer, String(selectivity)], urlString: "https://romdat.com/user/\(userid)/factors/update")
        postWithCompletion(parameters:  [userid, factor, answer, String(selectivity)], urlString: "https://romdat.com/user/\(userid)/factors/update") { success, result in
            
                print (result)
        }
        
    }
       
    
    // when a question is chosen (tapped)
    @objc func tappedMe(sender : MyTapGesture) {

        answered = true
        // adjust prompts for if slider value exists
        if (importanceSlider.value == 0.50) {
            
            sliderBox.layer.borderWidth = 1.0
            sliderBox.layer.borderColor = medgray.cgColor
            sliderBox.backgroundColor =  graphgray
            
            //nextButton.backgroundColor = yellow
            //prevButton.backgroundColor = yellow
 
            
        }
        else {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
            //nextButton.backgroundColor = UIColor.clear
            //prevButton.backgroundColor = UIColor.clear
        }
        
    
        // clear out button styles
        answerTexts.forEach { ck in
            //ck.layer.borderColor = black.cgColor
            //ck.layer.borderWidth = 0.0
            ck.backgroundColor = UIColor.clear
            
            ck.layer.borderWidth = 0.0
            ck.layer.borderColor = romDarkGray.cgColor
            ck.font = UIFont(name:"HelveticaNeue", size: 17.0)
            
        }
        
        radios.forEach { radio in
            radio.image = UIImage(named:"radio-button-off-200x200.png")
        }
       
        print(sender.title)
        print(sender.value)
        
        
        if (sender.title == "A1") {
            //A1text.layer.backgroundColor = romLightGray.cgColor
            A1text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A1text.layer.borderWidth = 0.0
            radio1.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A2") {
            //A2text.layer.backgroundColor = romLightGray.cgColor
            A2text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A2text.layer.borderWidth = 0.0
            radio2.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A3") {
            //A3text.layer.backgroundColor = romLightGray.cgColor
            A3text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A3text.layer.borderWidth = 0.0
            radio3.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A4") {
            //A4text.layer.backgroundColor = romLightGray.cgColor
            A4text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A4text.layer.borderWidth = 0.0
            radio4.image = UIImage(named:"radio-button-on-200x200.png")
            saveFactorAnswer(userid: userId, factor: String(sender.fq), answer: String(sender.value), selectivity: currentSelectivity)
        }
        if (sender.title == "A5") {
            //A5text.layer.backgroundColor = romLightGray.cgColor
            A5text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
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
    }


}

