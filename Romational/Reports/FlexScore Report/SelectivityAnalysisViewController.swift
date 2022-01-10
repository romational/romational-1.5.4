//
//  SelectivityAnalysisViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/27/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit
//import Charts

class SelectivityAnalysisViewController: UIViewController, MyFactorsProtocol, FactorIconsProtocol, FactorSelectivityProtocol {

   
    // bring in factors
    var factorIconList : NSDictionary = NSDictionary()
    func factorIconsDownloaded(factorIcons: NSDictionary) {
        factorIconList = factorIcons
        //print (factorIconList)
        
        let factorSelectivity = FactorSelectivity()
        factorSelectivity.delegate = self
        factorSelectivity.downloadFactorIcons(userid: userId)
       
    }
    
    // bring in factor selectivity
    var factorSelectivityIconList : NSArray = NSArray()
    
    func factorSelectivityDownloaded(selectivityIcons: NSArray) {
        factorSelectivityIconList = selectivityIcons
        
        //print (factorSelectivityIconList)
        
        let myFactors = MyFactorAnswers()
        myFactors.delegate = self
        myFactors.downloadMyFactorAnswers(userid: userId)
        
        
    }
    
    
    // MARK: Downloads
    var myFactors: NSArray = NSArray()
    var selectivity = 0
    var types  = [String]()
      
    var runTot  = 0.0
    
    func myFactorAnswersDownloaded(factors: NSArray) {
    
        myFactors = factors

        var low     = 0.0
        var medlow  = 0.0
        var med     = 0.0
        var medhigh = 0.0
        var high    = 0.0
        
     
        for factor in myFactors {
        //for (index,factor) in factors.enumerated() {
        
            let factorAnswer = factor as! MyFactorAnswersModel
            //print (factorAnswer)
            
            //let answer = Int(factorAnswer.answerId!)!
            //print (answer)
            
            let importance = Double(factorAnswer.selectivity!)!
           
            selectivity += Int(importance*100)
        
            
            //print ("ranges here")
            for i in 0..<Ranges.count {
                
                let thisRange = Ranges[i] as? NSDictionary
                
                //print (thisRange!["low"]!)
                
                //let rangeName = thisRange!["name"] as? String
                let lowRange  = Double((thisRange!["low"] as? String)!)! / 100.0
                let highRange = Double((thisRange!["high"] as? String)!)! / 100.0
                
                if (importance > lowRange) && (importance <= highRange) {
                    if i == 0 {
                        low = low + 1
                    }
                    if i == 1 {
                        medlow = medlow + 1
                    }
                    if i == 2 {
                        med = med + 1
                    }
                    if i == 3 {
                        medhigh = medhigh + 1
                    }
                    if i == 4 {
                        high = high + 1
                    }
                }
            }
     
                    
            runTot = runTot + 1
            
        }
        
        runTot = low + medlow + med + medhigh + high
        
        // crunch decimal percents for chart
        low     = (low / runTot)
        medlow  = (medlow / runTot)
        med     = (med / runTot)
        medhigh = (medhigh / runTot)
        high    = (high / runTot)
        
        
        for i in 0..<Ranges.count {
            let thisRange = Ranges[i] as? NSDictionary
            let rangeName = thisRange!["name"] as? String
            types.append(rangeName!)
        }
        
        //let types = ["Not at All", "Somewhat", "Moderately", "Very", "Extremely"]
        let myVals = [Double(low), Double(medlow), Double(med), Double(medhigh), Double(high)]
        
        printFactorColumns()
        
        printSelectivityPieChart(dataPoints: types, values: myVals)
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
    
        slideController = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as? UserOptionsViewController
           
            
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
    
    
    // sub nav
    
    @IBAction func reportMenuButton(_ sender: Any) {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           let destination = storyboard.instantiateViewController(withIdentifier: "ReportMenu") as! ReportViewController
           
       destination.modalPresentationStyle = .fullScreen
           self.present(destination, animated: true, completion: nil)
       }
    
    
    @IBAction func graphButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityScore") as! SelectivityViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    @IBAction func breakdownButton(_ sender: Any) {
    }
    @IBAction func summaryButton(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SelectivityRankings")
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    
    }
    
    
    // info button
    @IBAction func getInfo(_ sender: Any) {
    
        let pageInfo = VCS["SelectivityAnalysis"] as! VCSInfoModel
       
        let popupInfo   = pageInfo.popup ?? "n/a"
        let popupTitle  = pageInfo.popupTitle ?? "Score Info"
        let popupButton = pageInfo.popupButton ?? "Ok, Got It"
        
        let alertController:UIAlertController = UIAlertController(title: popupTitle, message: popupInfo, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: popupButton, style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    // view variables
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var analysisTitle: UILabel!
    @IBOutlet weak var analysisIntro: UILabel!
    
    @IBOutlet weak var selectivityPieChart: UIView!
    
    var colors: [UIColor] = []
   
   
    
    // columns
    @IBOutlet weak var colHead1: UILabel!
    @IBOutlet weak var colHead2: UILabel!
    @IBOutlet weak var colHead3: UILabel!
    @IBOutlet weak var colHead4: UILabel!
    @IBOutlet weak var colHead5: UILabel!
    
    @IBOutlet weak var col1: UIView!
    @IBOutlet weak var col2: UIView!
    @IBOutlet weak var col3: UIView!
    @IBOutlet weak var col4: UIView!
    @IBOutlet weak var col5: UIView!
    
    @IBOutlet weak var col1Percent: UILabel!
    @IBOutlet weak var col2Percent: UILabel!
    @IBOutlet weak var col3Percent: UILabel!
    @IBOutlet weak var col4Percent: UILabel!
    @IBOutlet weak var col5Percent: UILabel!
    
    
    
    // MARK: VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let pageInfo = VCS["SelectivityAnalysis"] as? VCSInfoModel
        
        if (pageInfo?.title != nil) {
           // analysisTitle.text = pageInfo!.title
        }
        if (pageInfo?.info != nil) {
             
            analysisIntro.text = pageInfo!.info
        }
        
        
        let factorIconList = FactorIcons()
        factorIconList.delegate = self
        factorIconList.downloadIcons()
        
        // turn on spinner for pie chart loading
        self.showSpinner(onView: self.view)
        
        // used for pie chart
        colors.append(romTeal)
        colors.append(green)
        colors.append(yellow)
        colors.append(romOrange)
        colors.append(romPink)
        
        
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
             self.summaryButton((Any).self)
             
         }
             
         if (sender.direction == .right) {
             print("Swipe Right")
            // let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
             //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
             self.graphButton((Any).self)
         }
     }
    
    
    @objc func iconTap(gestureRecognizer: FactorIconGestureRecognizer)
    {
       
        goBack = "SelectivityAnalysis"
        
        //print (gestureRecognizer.factorId)
        
        let fq = gestureRecognizer.factorId
        factorOpt = fq!
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
        secondViewController.FQ = fq!
        
        //NewViewController create DisplayImg UIImageView object
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    
    

    
    func printSelectivityPieChart(dataPoints: [String], values: [Double]) {
        /* Charts IO taken out for 1.5.1
         
         // 1. Set ChartDataEntry
          var dataEntries: [ChartDataEntry] = []
          for i in 0..<dataPoints.count {
             let dataEntry = PieChartDataEntry(value: values[i], label: "")
            dataEntries.append(dataEntry)
          }
         
          // 2. Set ChartDataSet
         let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
          pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
         
         pieChartDataSet.drawValuesEnabled = false
        
          // 3. Set ChartData
         let pieChartData = PieChartData(dataSet: pieChartDataSet)
          
         let format = NumberFormatter()
         format.numberStyle = .percent
         format.percentSymbol = "%"
          
         selectivityPieChart.holeRadiusPercent = 0
         selectivityPieChart.transparentCircleRadiusPercent = 0.0
         
        //let formatter = DefaultValueFormatter(formatter: format)
        //pieChartData.setValueFormatter(formatter)
        
        
         // format legend
         let legend = selectivityPieChart.legend
         legend.enabled = false
         
          // 4. Assign it to the chart’s data
          selectivityPieChart.data = pieChartData
         */
        
        let pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: 0, y: 0, width: selectivityPieChart.frame.size.width, height: selectivityPieChart.frame.size.height)
        
        var pieSegments : [Segment] = []
        for i in 0..<dataPoints.count {
            
            pieSegments.append(Segment(color: colors[i], value: values[i]))
        }
        pieChartView.segments = pieSegments
        /*
        pieChartView.segments = [
            
            Segment(color: .red, value: 57),
            Segment(color: .blue, value: 30),
            Segment(color: .green, value: 25),
            Segment(color: .yellow, value: 40)
        ]
         */
        selectivityPieChart.addSubview(pieChartView)
        
     }

     /* used for charts io taken out for 1.5.1
     private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
         var colors: [UIColor] = []
        
         colors.append(romTeal)
         colors.append(green)
         colors.append(yellow)
         colors.append(romOrange)
         colors.append(romPink)
         
         return colors
     }
    */
    
    var factorCols = [UIView]()
    var factorLegend = [UILabel]()
    
    func printFactorColumns() {
      
        print ("factor columns begin")
        colHead1.text = types[0]
        colHead2.text = types[1]
        colHead3.text = types[2]
        colHead4.text = types[3]
        colHead5.text = types[4]
        
        colHead1.backgroundColor = romTeal
        colHead2.backgroundColor = green
        colHead3.backgroundColor = yellow
        colHead4.backgroundColor = romOrange
        colHead5.backgroundColor = romPink
            
        factorCols.append(col1)
        factorCols.append(col2)
        factorCols.append(col3)
        factorCols.append(col4)
        factorCols.append(col5)
        
        factorLegend.append(col1Percent)
        factorLegend.append(col2Percent)
        factorLegend.append(col3Percent)
        factorLegend.append(col4Percent)
        factorLegend.append(col5Percent)
        
        //print ("hmm")
        
        for i in 0..<factorSelectivityIconList.count {
            
            let factSelIcon = factorSelectivityIconList[i] as! FactorSelectivityModel
            
            //print (factSelIcon)

            let factorIds = factSelIcon.ids!
            
            //print(factSelIcon.rank)
            //print (factSelIcon.total!)
            //print (myFactors.count)
            
            let percentAmount = Int( ( Double(factSelIcon.total!) / Double(runTot) ) * 100)
            
            //print (percentAmount)
            
            factorLegend[i].text = String("\(percentAmount)%")

            // bring in the column view
            let thisColumn = factorCols[i]
            var imageY = 10
            
            // cycle through and add the image view icons
            for factorId in factorIds {
                
                let factId = Int((factorId as! NSString) as String)
                //print (factId)
                
                if factorIconList[factId as Any] != nil {
                    let thisFactor = factorIconList[factId!] as! FactorIconModel
                
                    let factorImage = UIImage(named: thisFactor.image!)
                    
                    let factorImageView = UIImageView(image: factorImage!)
                    
                   // Add click & gesture recognizer to your image view
                    
                    factorImageView.isUserInteractionEnabled = true
                    
                    let recognizer = FactorIconGestureRecognizer(target: self, action: #selector(self.iconTap), factorId: thisFactor.order!)
                    
                    recognizer.numberOfTapsRequired = 1
                    factorImageView.addGestureRecognizer(recognizer)
                    
                    factorImageView.frame = CGRect(x: 0, y: imageY, width: 60, height: 60)
                   
                    // label for factor
                    let factorLabel = UILabel()
                    factorLabel.text = thisFactor.name
                    factorLabel.textColor = romDarkGray
                    factorLabel.textAlignment = .center
                    factorLabel.font = UIFont.systemFont(ofSize: 12)
                    factorLabel.frame = CGRect(x:0,y:imageY+62, width:60,height: 15)
                    
                    // add to column
                    thisColumn.addSubview(factorImageView)
                    thisColumn.addSubview(factorLabel)
                    
                    //update Y value
                    imageY = imageY + 85
                    
                }
                
            }
            
        }
        
    }
    
}

class FactorIconGestureRecognizer : UITapGestureRecognizer {
    
    var factorId : Int?
    // any more custom variables here
    
    init(target: AnyObject?, action: Selector, factorId : Int) {
        super.init(target: target, action: action)
        
        self.factorId = factorId
    }
    
}

