//
//  MyTypeViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/24/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

class RomtypeViewController: UIViewController, RomtypeQuestionProtocol, MyRomtypeAnswersProtocol {
    

    
    let romtypeModel = RomtypeModel()
    
    
    // MARK: import question answer data
    
    var romtypeQuestions: NSArray = NSArray()
    
    func questionsDownloaded(questions: NSArray) {
        romtypeQuestions = questions

        printRomtypeQuestions(rq : RQ)
        
        let rtQuestions = romtypeQuestions[RQIndex] as! RomtypeQuestionModel

        romTypeInfo.text = rtQuestions.info
        
        // nav light bar
        let navBarBottom = navBar.frame.origin.y + navBar.bounds.size.height + 2
        let viewWidth = Int(view.bounds.width) - romtypeQuestions.count
        let navLightWidth = Int(viewWidth) / romtypeQuestions.count
        var navPos = 1
        
        // cycle through answers for lights
        var ct = 0
        myRomtypeAnswers.forEach { romA in
            
            let myAnswer = myRomtypeAnswers[ct] as! MyRomtypeAnswersModel
            let thisRTA = myAnswer.answerId
            //print (thisRTA)
            
            let navLight = UIButton(frame: CGRect(x: navPos, y: Int(navBarBottom), width: navLightWidth, height: 6))
            
            navLight.addTarget(self, action: #selector(gotoNavLight), for: .touchUpInside)
            navLight.tag = ct + 1
            
            if (thisRTA == "") {
                navLight.layer.backgroundColor = romPink.cgColor
            }
            else {
                navLight.layer.backgroundColor = romLightGray.cgColor
            }
            view.addSubview(navLight)
            
            navPos = navPos + navLightWidth + 1
            ct = ct + 1
        }
        
    }
    
    // bring in myFactors
    var myRomtypeAnswers: NSArray = NSArray()
    
    func myRomtypeAnswersDownloaded(romtypeAnswers: NSArray) {
        myRomtypeAnswers = romtypeAnswers
        
        let downloadRomtypeQuestions = RomtypeQuestions()
        downloadRomtypeQuestions.delegate = self
        downloadRomtypeQuestions.downloadQuestions()
        
    }
    
    
    @objc func gotoNavLight (sender: UIButton!) {
        
        let buttonTag: UIButton = sender
        RQ = buttonTag.tag
    
        //print (RQ)
        printRomtypeQuestions(rq : RQ)
    }
    
 
    
    // nav links
    @IBAction func allRomtypeQs(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RTQIntro") as! RTQIntroViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    
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
            
        self.view.insertSubview(self.slideController.view, at: 50)
            //addChildViewController(controller)
        self.slideController.didMove(toParentViewController: self)
            
        showMenu = true
       
    }
    
    
    // go back return links
    
    @IBOutlet weak var goBackButton: UIButton!
    
    @IBAction func goBackClick(_ sender: Any) {
    
        if (goBack == "RomtypeFoundation") {
           
            goBack = ""
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "FoundationReport") as! RomtypeFoundationViewController
                
            destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false, completion: nil)
            
        }
        
        if (goBack == "RomtypeMindset") {
          
            goBack = ""

            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "MindsetReport") as! RomtypeMindsetViewController
                
            destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false, completion: nil)
            
        }
        
        if (goBack == "MyRomtypeData") {
          
            goBack = ""

            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "MyRomtypeData") as! MyRomtypeDataViewController
                
            destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false, completion: nil)
            
        }
        
        if (goBack == "") {
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "RTQIntro") as! RTQIntroViewController
        
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false)
            
        }
        
    }
    
    
    // MARK: prev next buttons
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextButton(_ sender: Any) {
        
        // spinner
        self.showSpinner(onView: self.view)
        
        //romtypeModel.updateRomtypeView(rq: RQ)
        romtypeOpt = 0
        RQ = RQ + 1
        if (RQ <= romtypeQuestions.count) {
            
            let myAnswers = MyRomtypeAnswers()
            myAnswers.delegate = self
            myAnswers.downloadMyRomtypeAnswers(userid: userId)
            
            //printRomtypeQuestions(rq : RQ)
        }
        else {
            //nextBtn.setTitle("View Report", for: .normal)
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeComplete") as! RomtypeCompleteViewController
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: true)
        }
    }
    
    
    @IBOutlet weak var prevBtn: UIButton!
    
    @IBAction func prevButton(_ sender: Any) {
        
        // spinner
        self.showSpinner(onView: self.view)
        
        //romtypeModel.updateRomtypeView(rq: RQ)

        romtypeOpt = 0
        RQ = RQ - 1
        
        let myAnswers = MyRomtypeAnswers()
        myAnswers.delegate = self
        myAnswers.downloadMyRomtypeAnswers(userid: userId)
        
        //printRomtypeQuestions(rq : RQ)
    }
    
    
    // MARK: question details
    
    @IBOutlet weak var thisScrollView: UIScrollView!
    @IBOutlet var romtypeView: UIView!
    @IBOutlet weak var navBar: UIView!
    
    var ThisRomtype = String()
    var RQ = Int()
    var RQIndex = Int()
 
    
    @IBOutlet weak var spacerView: UILabel!
    
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var romTypeInfo: UILabel!
   
    @IBOutlet weak var typeImage: UIImageView!
    
    @IBAction func typeInfo(_ sender: Any) {
    
        let rtQuestions = romtypeQuestions[RQIndex] as! RomtypeQuestionModel

        let message = rtQuestions.info
        let alertController:UIAlertController = UIAlertController(title: "About this Question", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK, Got It!", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // MARK: answer variables

    // answer box view
    @IBOutlet weak var A1View: UIView!
    @IBOutlet weak var A2View: UIView!
    @IBOutlet weak var A3View: UIView!
    @IBOutlet weak var A4View: UIView!
    @IBOutlet weak var A5View: UIView!

    var checkviews = [UIView]()
    
    // answer text label
    @IBOutlet weak var A1text: UITextView!
    @IBOutlet weak var A2text: UITextView!
    @IBOutlet weak var A3text: UITextView!
    @IBOutlet weak var A4text: UITextView!
    @IBOutlet weak var A5text: UITextView!
    
    var checkboxes = [UITextView]()
    
    // radio buttons
    @IBOutlet weak var radio1: UIButton!
    @IBOutlet weak var radio2: UIButton!
    @IBOutlet weak var radio3: UIButton!
    @IBOutlet weak var radio4: UIButton!
    @IBOutlet weak var radio5: UIButton!
    
    var radios = [UIButton]()

    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        //spacerView.layer.addBorder(edge: UIRectEdge.bottom, color: romDarkGray, thickness: 1.0)
        
        // build arrays
        checkviews.append(A1View)
        checkviews.append(A2View)
        checkviews.append(A3View)
        checkviews.append(A4View)
        checkviews.append(A5View)
        
        checkboxes.append(A1text)
        checkboxes.append(A2text)
        checkboxes.append(A3text)
        checkboxes.append(A4text)
        checkboxes.append(A5text)
        
        radios.append(radio1)
        radios.append(radio2)
        radios.append(radio3)
        radios.append(radio4)
        radios.append(radio5)
        
        checkviews.forEach { ck in
           
        }
        
        checkboxes.forEach { ckb in
            ckb.layer.borderWidth = 0
            ckb.layer.cornerRadius = 10
            
            ckb.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
            ckb.centerVertically()
        }
        
        // user logs
        if (romtypeStarted == "") {
            updateUserLogs(userid: userId, item: "romtype-started")
        }
        
        // bring in answers
        let myAnswers = MyRomtypeAnswers()
        myAnswers.delegate = self
        myAnswers.downloadMyRomtypeAnswers(userid: userId)
        
        
        goBackButton.layer.cornerRadius = 20
        goBackButton.layer.masksToBounds = false
        goBackButton.layer.shadowColor = romDarkGray.cgColor
        goBackButton.layer.shadowOpacity = 0.3
        goBackButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        goBackButton.layer.shadowRadius = 4
        
        // Do any additional setup after loading the view.
        print (goBack)
        if (goBack == "RomtypeFoundation") || (goBack == "RomtypeMindset") || (goBack == "MyRomtypeData") {
            goBackButton.isHidden = false
            if (goBack == "RomtypeFoundation") {
                goBackButton.setTitle("RomType Foundation", for: .normal)
            }
            if (goBack == "RomtypeMindset") {
                goBackButton.setTitle("RomType Mindset", for: .normal)
            }
            if (goBack == "MyRomtypeData") {
                goBackButton.setTitle("My Romtype Answers", for: .normal)
            }
        
        }
        else {
            goBackButton.isHidden = true
            
        }
        
        
    }


    
    func printRomtypeQuestions(rq : Int) {
        
        // clear out on re-print
        checkviews.forEach { ck in
           
        }
        
        checkboxes.forEach { ckb in
            
            ckb.layer.borderColor = romDarkGray.cgColor
            ckb.layer.borderWidth = 0
            ckb.layer.cornerRadius = 10
            ckb.layer.backgroundColor = UIColor.clear.cgColor
            ckb.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
            ckb.centerVertically()
            ckb.font = UIFont(name:"HelveticaNeue", size: 17.0)
       
        }
        
        let offImage = UIImage(named: "radio-button-off-200x200.png") as UIImage?
        
        radios.forEach { radio in
            radio.setImage(offImage, for: .normal)
        }
        
        //q ct
        let totalRQs = romtypeQuestions.count
        //print ("there are \(totalRQs) questions")
        
        if romtypeOpt != 0 {
            RQ = romtypeOpt
        }
        // default intro setting
        else if rq == 0 {
                   
            RQ = myRomtypeAnswers.count
            //print ("RQ is \(RQ)")
            
            // if no stored factors set to 1
            if RQ == 0 {
                RQ = 1
            }
                
            // else check my stored factors to get first missing RQ
            else {
                
              
                for i in 0..<myRomtypeAnswers.count {
                    
                    //ct = ct + 1
                    RQ = i + 1
                    
                    let myRomtypeAnswer = myRomtypeAnswers[i] as! MyRomtypeAnswersModel
                    
                    //print (myRomtypeAnswer)
                    
                    let answerId = Int(myRomtypeAnswer.answerId ?? "0" )
                    print (answerId)
                    if (answerId == 0) || (answerId == nil) {
                        
                        break;
                    }
                
                   // print ("RQ is \(RQ)")
                }
                
            }
        }
        // if fq is set then make RQ that question
        else {
            RQ = rq
        
        }
        
        RQIndex = RQ - 1
        
        print ("\(totalRQs) Questions - rq \(rq) - RQ \(RQ) - RQIndex \(RQIndex)")
        
        var rtQuestions = RomtypeQuestionModel()
        
        //print (rtQuestions)
        
        if (RQ <= romtypeQuestions.count) {
        
            // ** need to limit out of bounds on this **
            rtQuestions = romtypeQuestions[RQIndex] as! RomtypeQuestionModel
            
            let rtqId       = rtQuestions.id!
            let rtqOrder    = rtQuestions.order!
            let rtqName     = rtQuestions.name!
            let rtqImage    = rtQuestions.image!
            let rtqQuestion = rtQuestions.question!
            
            //print ("order is \(rtqOrder)")
                
            // load up question
        questionNumber.text = ("Question \(RQ) of \(totalRQs)")
            questionTitle.text = rtqName.uppercased()
            romTypeInfo.text = rtQuestions.info!
                
            //typeQuestion.text = rtqQuestion
           // typeImage.image = UIImage(named: rtqImage)
            
            // set the tap
            func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
                return true
            }
            
            
            var answer = 0
            
            if myRomtypeAnswers.count != 0 {
                if myRomtypeAnswers.count > RQIndex {
                    //print ("ok")
                    
                    if (RQ == rtqOrder) {
                        
                        let myAnswer = myRomtypeAnswers[RQIndex] as! MyRomtypeAnswersModel
                        
                        //print (myAnswer)
                        
                        if myAnswer.answerId! != "" {
                            answer = Int(myAnswer.answerId!)!
                            //print (answer)
                            nextBtn.isEnabled = true
                            prevBtn.isEnabled = true
                        }
                        else {
                            nextBtn.isEnabled = false
                            //prevBtn.isEnabled = false
                        }
                    }
                }
            }
            
            
            // clear the checkboxes
            checkboxes.forEach { ck in
                ck.text = ""
                
            }
            
            
            let qAnswers = rtQuestions.answers as? Array<Any>
            let qAnswer = qAnswers?[0] as? [String:Any]
            
            let totalAnswers = qAnswers?.count
            
            for i in 0...totalAnswers! - 1 {
                
                let answerId = checkboxes[i]
            
                let qAnswer = qAnswers?[i] as? [String:Any]
           
                let thisAnswer = qAnswer?["romtypeAnswer_text"] as? String
                answerId.text = thisAnswer
            
                
                checkboxes[i].centerVertically()
                
                let thisAnswerId = qAnswer?["romtypeAnswer_id"] as? String
              
                // check current answer to check box
                if Int(thisAnswerId!) == answer {
                   
                    let image = UIImage(named: "radio-button-on-200x200.png") as UIImage?
                    radios[i].setImage(image, for: .normal)
                   
                    //checkboxes[i].layer.backgroundColor = romLightGray.cgColor
                    checkboxes[i].font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
                }
                else {
                    //checkviews[i].backgroundColor = white
                    // checkboxes[i].backgroundColor = white
                   
                }
                
               
                
                // setup the tap
                let tap = MyTapGesture(target: self, action: #selector(RomtypeViewController.tappedMe))
                
                tap.title = "A\(i+1)"
                tap.id = Int(thisAnswerId!)!
                tap.rtq = rtqId
                
                radios[i].addGestureRecognizer(tap)
                radios[i].isUserInteractionEnabled = true
                
                let tap2 = MyTapGesture(target: self, action: #selector(RomtypeViewController.tappedMe))
                
                tap2.title = "A\(i+1)"
                tap2.id = Int(thisAnswerId!)!
                tap2.rtq = rtqId
                
                checkboxes[i].addGestureRecognizer(tap2)
                checkboxes[i].isUserInteractionEnabled = true
                
            }
          
            
        }
        // RQ out of range - send to confirm scene
        else {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeComplete") as! RomtypeCompleteViewController
                navigationController?.pushViewController(destination, animated: true)
        }
      
        
        self.removeSpinner()
        
        let point = self.navBar.frame.origin
        let newpoint = CGPoint(x: point.x, y: point.y - 50)
        
        self.thisScrollView.contentOffset = newpoint
        
        //self.thisScrollView.contentOffset(CGPoint(x: x, y: 0))
    }
    
    
    @objc func tappedMe(sender : MyTapGesture) {
        
    
        checkviews.forEach { cb in
            cb.backgroundColor = UIColor.clear
            
        }
        
        checkboxes.forEach { ckb in
            ckb.layer.backgroundColor = UIColor.clear.cgColor
            //ckb.layer.borderWidth = 1
            ckb.font = UIFont(name:"HelveticaNeue", size: 17.0)
        }
        
        nextBtn.isEnabled = true
        prevBtn.isEnabled = true
        
        //print(sender.title)
       
        let offImage = UIImage(named: "radio-button-off-200x200.png") as UIImage?
        let onImage = UIImage(named: "radio-button-on-200x200.png") as UIImage?
        
        radios.forEach { radio in
            radio.setImage(offImage, for: .normal)
        }
        
        if (sender.title == "A1") {
            //A1text.backgroundColor = romLightGray
            A1text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A1text.layer.borderWidth = 0.0
            radio1.setImage(onImage, for: .normal)
            saveRomtypeAnswer(userid: userId, question: String(sender.rtq), answer: String(sender.id))
        }
        if (sender.title == "A2") {
            //A2text.backgroundColor = romLightGray
            A2text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A2text.layer.borderWidth = 0.0
            radio2.setImage(onImage, for: .normal)
            saveRomtypeAnswer(userid: userId, question: String(sender.rtq), answer: String(sender.id))
        }
        if (sender.title == "A3") {
            //A3text.backgroundColor = romLightGray
            A3text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A3text.layer.borderWidth = 0.0
            radio3.setImage(onImage, for: .normal)
            saveRomtypeAnswer(userid: userId, question: String(sender.rtq), answer: String(sender.id))
        }
        if (sender.title == "A4") {
            //A4text.backgroundColor = romLightGray
            A4text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A4text.layer.borderWidth = 0.0
            radio4.setImage(onImage, for: .normal)
            saveRomtypeAnswer(userid: userId, question: String(sender.rtq), answer: String(sender.id))
        }
        if (sender.title == "A5") {
            //A5text.backgroundColor = romLightGray
            A5text.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            A5text.layer.borderWidth = 0.0
            radio5.setImage(onImage, for: .normal)
            saveRomtypeAnswer(userid: userId, question: String(sender.rtq), answer: String(sender.id))
        }
        //print("Tapped on Image")
        
        
    }
    
    func saveRomtypeAnswer(userid: String, question: String, answer: String){
        
        //post(parameters: [userid, question, answer], urlString: "http://romadmin.com/saveRomtypeAnswers.php")
        post(parameters: [userid, question, answer], urlString: "https://romdat.com/user/\(userid)/romtypes/update")
        
    }
    
    
    class MyTapGesture: UITapGestureRecognizer {
        var title = String()
        var id = Int()
        var rtq = Int()
    }
    
    
}


