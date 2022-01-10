//
//  RomtypeMindsetViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/19/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit
//import Charts

class RomtypeMindsetViewController: UIViewController, MyRomtypeProtocol {
   
    
    // bring in romtype info
    var myRomtype = NSArray()
    
    func myRomtypeDownloaded(myRomtypeInfo: NSArray) {
        
        myRomtype = myRomtypeInfo
       
        /*
        if let first = myRomtype[0] as? [String: Any] {
    
          let firstImage  = first["image"] as? String
            let firstName   = first["name"] as? String
            let firstInfo   = first["info"] as? String
            let firstDefine = first["define"] as? String
            
        }
        */
        
        if let stats = myRomtype[2] as? [String: Any] {
            
            let cas = stats["cas"] as! String
            let dat = stats["dat"] as! String
            let com = stats["com"] as! String
                  
            let types = ["Casual", "Dating", "Committed"]
            let myVals = [Double(cas), Double(dat), Double(com)]
            
            buildStackedBar(labels: types, data: myVals.map{ Double($0!) } )
        
        }
        
        
        if let romtypesArray = myRomtype[3] as? [String:Any] {
            
          
            var posY  = questionBreakdown.frame.origin.y + 60
            
            
            if let romtypeQuestions = romtypesArray["questions"] as? [[String: Any]] {
            
                
                for question in romtypeQuestions {
                
                
                    let rtqIcon = UIImageView()
                    
                    rtqIcon.frame = CGRect(x: 10, y: posY, width: 60, height: 60)
                    
                    let label = UILabel(frame: CGRect(x: 80, y: posY+20, width: 100, height: 20))
                    
                    // took out if loop to solve always succeeds error 11.17.21
                    let answerStats = question
                        
                        print (answerStats)
                      
                        label.text = answerStats["name"] as? String
                     
                        breakdownView.addSubview(label)
                        
                        // rtq icon image
                        rtqIcon.image = UIImage(named: answerStats["image"] as! String)
                        
                       let tap = MyTapGesture(target: self, action: #selector(tappedMe))
                        tap.q = answerStats["order"] as! String
                        tap.numberOfTapsRequired = 2
                        
                        rtqIcon.addGestureRecognizer(tap)
                        rtqIcon.isUserInteractionEnabled = true
                        breakdownView.addSubview(rtqIcon)
                        
                        var posX = 180
                        
                        let rtqCas =  (Double(answerStats["cas"] as? String ?? "0.0")! / 100.0) * 180
                        
                        // rtq result view bkgds
                        let rtqCasView = UIView(frame: CGRect(x: posX, y:  Int(posY), width: Int(rtqCas), height: 60))
                        rtqCasView.backgroundColor = lightgray
                        
                       
                        
                        posX = posX + Int(rtqCas)
                      
                        let rtqDat =  (Double(answerStats["dat"] as? String ?? "0.0")! / 100.0) * 180
                        
                        // rtq result view bkgds
                        let rtqDatView = UIView(frame: CGRect(x: posX, y:  Int(posY), width: Int(rtqDat), height: 60))
                        rtqDatView.backgroundColor = medgray
                        
                       
                        posX = posX + Int(rtqDat)
                        
                        let rtqCom =  (Double(answerStats["com"] as? String ?? "0.0")! / 100.0) * 180
                        
                        // rtq result view bkgds
                        let rtqComView = UIView(frame: CGRect(x: posX, y:  Int(posY), width: Int(rtqCom), height: 60))
                        rtqComView.backgroundColor = darkgray
                        
                        if (rtqCas + rtqDat + rtqCom > 0) {
                            
                            breakdownView.addSubview(rtqCasView)
                            breakdownView.addSubview(rtqDatView)
                            breakdownView.addSubview(rtqComView)
                        
                        }
                        else {
                            
                            let noResult = UIView(frame: CGRect(x: 180, y:  Int(posY), width: 180, height: 60))
                            let label = UILabel(frame: CGRect(x: 0, y: 20, width: 180, height: 20))
                            
                        
                            
                            if (answerStats["answer"] == nil) {
                                label.text = "not answered yet"
                                label.textColor = red
                            }
                            else {
                                label.text = "not applicable"
                                
                            }
                            label.textAlignment = NSTextAlignment.center
                            noResult.addSubview(label)
                            breakdownView.addSubview(noResult)
                            
                        }
                        
                        
                    }
                    
                    posY = posY + 70
                    
                }
            
            
            // update view for scrolling?
            view.setNeedsLayout()
            
        }
        
        
    }
    
    // navigation
    
    var controller : UserOptionsViewController!
    
    @IBAction func gotoUserMenu(_ sender: Any) {
    
        controller = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as? UserOptionsViewController
            
        
         
             
         let height = self.view.frame.height
         let width = self.view.frame.width
             // default to width zero buttons icons hidden
         controller.view.frame = CGRect(x: 0, y: 40, width: 0, height: height)
         controller.userOptionLogo.isHidden = true
         controller.closeButton.isHidden = true
         controller.userButtons.forEach { button in
                 button.isHidden = true
             }
         controller.userIcons.forEach { icon in
                 icon.isHidden = true
             }
             
         controller.view.isUserInteractionEnabled = true
             
             // animate the display
         UIView.animate(withDuration: 0.6, animations: { self.controller.view.frame = CGRect(x:0, y:40, width: width, height: height) },
             completion: {(value: Bool) in
                 
            self.controller.userOptionLogo.isHidden = false
            self.controller.closeButton.isHidden = false
            self.controller.userButtons.forEach { button in
                     button.isHidden = false
                 }
            self.controller.userIcons.forEach { icon in
                     icon.isHidden = false
                 }
                 
         })
             
         self.view.insertSubview(self.controller.view, at: 20)
             //addChildViewController(controller)
         self.controller.didMove(toParent: self)
             
         showMenu = true
        
    }
    

    @IBAction func gotoMainMenu(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
            
    }
    
    @IBAction func reportMenuButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "ReportMenu") as! ReportViewController
        
    destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true, completion: nil)
    }
    
    
    @IBAction func romTypeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeReport") as! RomtypeReportViewController
        
    destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    @IBAction func foundationButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FoundationReport") as! RomtypeFoundationViewController
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false, completion: nil)
    }
    
    

    @IBAction func getInfo(_ sender: Any) {
    
        let pageInfo = VCS["RomtypeReport"] as? VCSInfoModel
        // setup info popup
        let message = pageInfo!.popup
        
        let alertController:UIAlertController = UIAlertController(title: "About Rom Types", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK, Got It", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    

    // view variables
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var breakdownView: UIView!
    @IBOutlet weak var questionBreakdown: UILabel!
    
    //@IBOutlet weak var barChartView: BarChartView!
    
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let getMyRomtype = MyRomtype()
        getMyRomtype.delegate = self
        getMyRomtype.downloadMyRomtype(userid: userId)
        
        
        scrollView.isScrollEnabled = true
        
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
             self.romTypeButton((Any).self)
             
         }
             
         if (sender.direction == .right) {
             print("Swipe Right")
            // let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
             //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
             self.foundationButton((Any).self)
         }
     }
    
    
    // when a question is chosen (tapped)
    @objc func tappedMe(sender : MyTapGesture) {
        
        //print (sender.q)
        
        goBack = "RomtypeMindset"
        romtypeOpt = Int(sender.q)!
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
        
        
    
    }
    
    class MyTapGesture: UITapGestureRecognizer {
         var q = String()
      
     }
    
    func buildStackedBar(labels: Array<String>, data: Array<Double>) {
        
        /*
        // 1. Set ChartDataEntry
             var dataEntries: [ChartDataEntry] = []
             for i in 0..<labels.count {
                let dataEntry = BarChartDataEntry(x: Double(i), y: Double(data[i]) )
               dataEntries.append(dataEntry)
                
             }
            
             // 2. Set ChartDataSet
            let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "Dimension Results")
             barChartDataSet.colors = dimensionColors(numbersOfColor: labels.count)
            barChartDataSet.valueFont = .systemFont(ofSize: 14)
        
            barChartDataSet.highlightEnabled = false
            barChartDataSet.highlightColor = yellow
            barChartDataSet.barShadowColor = graphgray
        
            let xAxis = barChartView.xAxis
            xAxis.drawAxisLineEnabled = false
            xAxis.drawGridLinesEnabled = false
            
            xAxis.labelPosition = .bottom
            xAxis.labelFont = .systemFont(ofSize: 14)
            //xAxis.granularity = 1
            xAxis.labelCount = 3
        
       let chartFormatter = MindsetChartLabelFormatter()
        /* take out to get it to go live 11.17.21
            for i in 0..<labels.count {
                
                chartFormatter.stringForValue(Double(i), axis: xAxis)
            }
         */
        
        // as? AxisValueFormatter removed for 11.17.21 fixes
        barChartView.xAxis.valueFormatter = chartFormatter
            
            
            //let leftAxisFormatter = NumberFormatter()
            
            let leftAxis = barChartView.leftAxis
            leftAxis.enabled = false
            
            leftAxis.labelPosition = .insideChart
            leftAxis.spaceTop = 0.15
            leftAxis.axisMinimum = 0
            leftAxis.axisMaximum = 1.0
            
            let rightAxis = barChartView.rightAxis
            rightAxis.enabled = false
            
            
             // 3. Set ChartData
            let barChartData = BarChartData(dataSet: barChartDataSet)
             
            let format = NumberFormatter()
            format.numberStyle = .percent
            format.percentSymbol = "%"
           
            let formatter = DefaultValueFormatter(formatter: format)
             barChartData.setValueFormatter(formatter)
            
            //PieChartView.setDrawGridBackground = false
             
            barChartView.legend.enabled = false
            barChartView.drawBarShadowEnabled = true
            //barChartView.drawBordersEnabled = true
            barChartView.doubleTapToZoomEnabled = false
        
        // 4. Assign it to the chart’s data
            barChartView.data = barChartData
        
       
        */
    }
    
    private func dimensionColors(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
       
        colors.append(lightgray)
        colors.append(medgray)
        colors.append(darkgray)
        
        return colors
    }
  
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        
        colors.append(pink)
        colors.append(red)
        
        return colors
    }
    
}

/*
final class MindsetChartLabelFormatter: NSObject, AxisValueFormatter {
    
    var columnLabels: [String]! = ["Casual", "Dating", "Committed"]
    
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        return columnLabels[Int(value)]
    }
}
*/
