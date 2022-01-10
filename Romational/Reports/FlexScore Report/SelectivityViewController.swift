//
//  SelectivityViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/24/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit
//import Charts

class SelectivityViewController: UIViewController, MyFactorsProtocol, FactorIconsProtocol, FactorSelectivityProtocol {


    // bring in factors
    var factorIconList : NSDictionary = NSDictionary()
    func factorIconsDownloaded(factorIcons: NSDictionary) {
        factorIconList = factorIcons
        //print (factorIconList[1])
        
        let factorSelectivity = FactorSelectivity()
        factorSelectivity.delegate = self
        factorSelectivity.downloadFactorIcons(userid: userId)
       
    }
    
    
    // bring in factor selectivity
    var factorSelectivityIconList : NSArray = NSArray()
    func factorSelectivityDownloaded(selectivityIcons: NSArray) {
        factorSelectivityIconList = selectivityIcons
        
        //print (factorSelectivityIcons)
        
        //printFactorColumns()
    }
    
    
    // download answers
    
    var myFactors: NSArray = NSArray()
    var selectivity = 0.0
    
    func myFactorAnswersDownloaded(factors: NSArray) {
       
        myFactors = factors
        
        var low     = 0.0
        var medlow  = 0.0
        var med     = 0.0
        var medhigh = 0.0
        var high    = 0.0
        var runTot  = 0.0
        
        for factor in myFactors {
        //for (index,factor) in factors.enumerated() {
        
            var factorAnswer = factor as! MyFactorAnswersModel
            //print (factorAnswer)
            
            let answer = Int(factorAnswer.answerId!)!
            //print (answer)
            
            let importance = Double(factorAnswer.selectivity!)!
           
            // add to calcs if not let empty
            //if (importance != 0.50) {
            print ("importance is \(importance)")
            selectivity += importance * 100
                
            //}
            runTot = runTot + 1
            
            //print ("ranges here")
            for i in 0..<Ranges.count {
                
                let thisRange = Ranges[i] as? NSDictionary
                
                //print (thisRange!["low"]!)
                let rangeName = thisRange!["name"] as? String
                let lowRange  = Double((thisRange!["low"] as? String)!)! / 100.0
                let highRange = Double((thisRange!["high"] as? String)!)! / 100.0
                
            
                if (importance > lowRange) && (importance <= highRange) {
                    if (i == 0) {
                        low = low + 1
                    }
                    if (i == 1) {
                        medlow = medlow + 1
                    }
                    if (i == 2) {
                        med = med + 1
                    }
                    if (i == 3) {
                        medhigh = medhigh + 1
                    }
                    if (i == 4) {
                        high = high + 1
                    }
                    
                }
                
            }
         
        }
        
        
        // crunch decimal percents for chart
        low     = (low / runTot)
        medlow  = (medlow / runTot)
        med     = (med / runTot)
        medhigh = (medhigh / runTot)
        high    = (high / runTot)
        
        
        let selectivityIndex = Int(round(selectivity / Double(runTot)))
        
        print ("selectivity index is \(selectivityIndex) \(selectivity) div by \(runTot) ")
        
        let indexGauge = GaugeView(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
        indexGauge.backgroundColor = .clear
        indexGauge.setBackgroundImage(imageName: "flex-gauge-bkgd.png", buffer: 0)
        gaugeBox.addSubview(indexGauge)
        
        
        
        // center the gauge in the box view
        indexGauge.centerXAnchor.constraint(equalTo: gaugeBox.centerXAnchor).isActive = true
        indexGauge.centerYAnchor.constraint(equalTo: gaugeBox.centerYAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1/4) {
            UIView.animate(withDuration: 1) {
                indexGauge.value = selectivityIndex
            }
        }
        
        mySelectivity.layer.borderWidth = 2
        mySelectivity.layer.cornerRadius = 20
        
        //print ("ranges here")
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
            let rangeName = thisRange!["name"] as? String
            let lowRange  = Int((thisRange!["low"] as? String)!)!
            let highRange = Int((thisRange!["high"] as? String)!)!
            let rangeInfo = thisRange!["info"] as? String
            
            if (selectivityIndex > lowRange) && (selectivityIndex <= highRange) {
                mySelectivity.text = rangeName!
                mySelectivityInfo.text = rangeInfo!
                
                
                if i == 0 {
         
                    mySelectivity.layer.borderColor = romTeal.cgColor
                }
                if i == 1 {
                   
                    mySelectivity.layer.borderColor = green.cgColor
                }
                if i == 2 {
                   
                    mySelectivity.layer.borderColor = yellow.cgColor
                }
                if i == 3 {
         
                    mySelectivity.layer.borderColor = romOrange.cgColor
                }
                if i == 4 {
                   
                    mySelectivity.layer.borderColor = romPink.cgColor
                }
                
            }
        }
   
        self.removeSpinner()
        
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
    
    @IBAction func getInfo(_ sender: Any) {
    
        let pageInfo = VCS["SelectivityReport"] as! VCSInfoModel
        
        let popupInfo   = pageInfo.popup ?? "n/a"
        let popupTitle  = pageInfo.popupTitle ?? "More Info"
        let popupButton = pageInfo.popupButton ?? "Ok, Got It"
        
        let alertController:UIAlertController = UIAlertController(title: popupTitle, message: popupInfo, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: popupButton, style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var chooseBreakdown: UIButton!
    @IBAction func graphsButton(_ sender: Any) {
    }
    
    @IBAction func breakdownButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityAnalysis") as! SelectivityAnalysisViewController
       
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
        
    }
    
    @IBAction func summaryButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityRankings") 
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    
    
    @IBAction func reportMenuButton(_ sender: Any) {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           let destination = storyboard.instantiateViewController(withIdentifier: "ReportMenu") as! ReportViewController
           
            destination.modalPresentationStyle = .fullScreen
           self.present(destination, animated: false, completion: nil)
       }
    
    
    // view variables
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var selectivityView: UIView!
    
    @IBOutlet weak var gaugeBox: UIView!
    
    @IBOutlet weak var selectivityTitle: UILabel!
    @IBOutlet weak var selectivityIntro: UILabel!
   
    @IBOutlet weak var mySelectivity: UILabel!
    @IBOutlet weak var mySelectivityInfo: UITextView!
    
    @IBOutlet weak var viewAnswersButton: UIButton!
    @IBOutlet weak var viewShareButton: UIButton!
    
    @IBAction func reviewAnswers(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyFactorData") as! MyFactorDataViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @IBAction func viewPDFReport(_ sender: Any) {
        self.getPDFlink()
        
    }
    
    // MARK: view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        let pageInfo = VCS["SelectivityReport"] as? VCSInfoModel
        
        if (pageInfo?.title != nil) {
            //selectivityTitle.text = pageInfo!.title
        }
        if (pageInfo?.info != nil) {
             
            selectivityIntro.text = pageInfo!.info
        }
    
        
        let myFactors = MyFactorAnswers()
        myFactors.delegate = self
        myFactors.downloadMyFactorAnswers(userid: userId)
        
        let factorIconList = FactorIcons()
        factorIconList.delegate = self
        factorIconList.downloadIcons()
  
        // turn on spinner for guage loading
        self.showSpinner(onView: self.view)
        
        //mySelectivity.font = UIFont.italicSystemFont(ofSize: 21)
        
        // style bottom buttons
        viewAnswersButton.layer.masksToBounds = false
        viewAnswersButton.layer.shadowColor = romDarkGray.cgColor
        viewAnswersButton.layer.shadowOpacity = 0.3
        viewAnswersButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        viewAnswersButton.layer.shadowRadius = 4
        viewAnswersButton.layer.cornerRadius = 30
        
        viewShareButton.layer.masksToBounds = false
        viewShareButton.layer.shadowColor = romDarkGray.cgColor
        viewShareButton.layer.shadowOpacity = 0.3
        viewShareButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        viewShareButton.layer.shadowRadius = 4
        viewShareButton.layer.cornerRadius = 30
        
        // swiping nav
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        
        
    }
    
    
    // in view functions
     
     @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
             
         if (sender.direction == .left) {
            print("Swipe Left")
             //let labelPosition = CGPoint(x: testName.frame.origin.x - 50.0, y: testName.frame.origin.y)
             //testName.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: testName.frame.size.width, height: testName.frame.size.height)
             self.breakdownButton((Any).self)
             
         }
             
         if (sender.direction == .right) {
             print("Swipe Right")
            // let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
             //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
             self.summaryButton((Any).self)
         }
     }
    
    
    func emailPDFlink() {
        let urlPath = "http://romadmin.com/createEmailPDF.php?userid=\(userId)"
        
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
                
                    self.viewShareButton.setTitle("Emailed", for: .normal)
                    self.viewShareButton.backgroundColor = orange
                    self.viewShareButton.setTitleColor(white, for: .normal)
                    self.viewShareButton.tintColor = white
                    self.viewShareButton.layer.cornerRadius = 20
                    
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
        let urlPath = "http://www.romadmin.com/createPDF.php?userid=\(userId)"
        
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
                //UIApplication.shared.openURL(URL(string: pdflink)!)
                guard let url = URL(string: pdflink) else {
                  return //be safe
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
        }
    }
    
}
