//
//  RomtypeFoundationViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/19/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit
import Charts

class RomtypeFoundationViewController: UIViewController, MyRomtypeProtocol {
   
    
    
    // bring in romtype info
    var myRomtype = NSArray()
    
    func myRomtypeDownloaded(myRomtypeInfo: NSArray) {
        
        myRomtype = myRomtypeInfo
        //print (myRomtype)
        if let first = myRomtype[0] as? [String: Any] {
    
            let firstImage  = first["image"] as? String
            let firstName   = first["name"] as? String
            let firstInfo   = first["info"] as? String
            let firstDefine = first["define"] as? String
            
            //let second = myRomtype[1] as? Array<Any>
        }
        
        if let stats = myRomtype[2] as? [String: Any] {
            
            print (stats)
            let sug = stats["sug"] as! String
            let bal = stats["bal"] as! String
            
            //print (sug)
            //print (bal)
            
            let players = ["Structured", "Balanced"]
            let goals = [Double(sug)!, Double(bal)!]

            // pie chart
            createSugBalChart(dataPoints: players, values: goals.map{ Double($0) })
        
        }
      
        
        //print (myRomtype[3])
        if let romtypesArray = myRomtype[3] as? [String:Any] {
            
            //var posY = 20
            var posY  = questionBreakdown.frame.origin.y + 60
            
            if let romtypeQuestions = romtypesArray["questions"] as? [[String: Any]] {
            
                //print (romtypeQuestions)
                
                for question in romtypeQuestions {
                
                    //print (question.key)
                    //print (question)
                
                    var rtqIcon = UIImageView()
                    
                    rtqIcon.frame = CGRect(x: 10, y: posY, width: 60, height: 60)
                    
                    var label = UILabel(frame: CGRect(x: 80, y: posY+20, width: 100, height: 20))
                    
                    
                    if let answerStats = question as?  [String:Any] {
                        
                            
                        // rtq label
                        label.text = answerStats["name"] as! String
                     
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
                        
                        let rtqSug =  (Double(answerStats["sug"] as? String ?? "0.0")! / 100.0) * 180
                        
                        // rtq result view bkgds
                        let rtqSugView = UIView(frame: CGRect(x: posX, y:  Int(posY), width: Int(rtqSug), height: 60))
                        rtqSugView.backgroundColor = pink
                        
                        
                        posX = posX + Int(rtqSug)
                      
                        let rtqBal =  (Double(answerStats["bal"] as? String ?? "0.0")! / 100.0) * 180
                        
                        // rtq result view bkgds
                        let rtqBalView = UIView(frame: CGRect(x: posX, y:  Int(posY), width: Int(rtqBal), height: 60))
                        rtqBalView.backgroundColor = red
                        
                        
                        if (rtqSug + rtqBal > 0) {
                        
                            breakdownView.addSubview(rtqSugView)
                            breakdownView.addSubview(rtqBalView)
                        
                        }
                        else {
                            
                            let noResult = UIView(frame: CGRect(x: 180, y:  Int(posY), width: 180, height: 60))
                            let label = UILabel(frame: CGRect(x: 0, y: 20, width: 180, height: 20))
                            if (answerStats["answer"] != nil) {
                                label.text = "not applicable"
                            }
                            else {
                                label.text = "not answered yet"
                                label.textColor = red
                            }
                            label.textAlignment = NSTextAlignment.center
                            noResult.addSubview(label)
                            breakdownView.addSubview(noResult)
                            
                        }
                        
                    }
                    
                    posY = posY + 70
                    
                }
            }
            
            // update view for scrolling?
            view.setNeedsLayout()
            
        }
        
    }
    
    
    
    var controller : UserOptionsViewController!
    
    @IBAction func gotoUserMenu(_ sender: Any) {
    
        controller = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as! UserOptionsViewController
            
        
         
             
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
         self.controller.didMove(toParentViewController: self)
             
         showMenu = true
        
    }
    

    // navigations
    
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
       
   @IBAction func mindsetButton(_ sender: Any) {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
       let destination = storyboard.instantiateViewController(withIdentifier: "MindsetReport") as! RomtypeMindsetViewController
       
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
    
    @IBOutlet weak var SugBalChartView: BarChartView!
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let getMyRomtype = MyRomtype()
        getMyRomtype.delegate = self
        getMyRomtype.downloadMyRomtype(userid: userId)
        
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
             self.mindsetButton((Any).self)
             
         }
             
         if (sender.direction == .right) {
             print("Swipe Right")
            // let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
             //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
             self.romTypeButton((Any).self)
         }
     }
    
    
    // when a question is chosen (tapped)
    @objc func tappedMe(sender : MyTapGesture) {
        
        //print (sender.q)
        
        goBack = "RomtypeFoundation"
        romtypeOpt = Int(sender.q)!
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
        
        
    
    }
    
    class MyTapGesture: UITapGestureRecognizer {
         var q = String()
      
     }
    
    
    func createSugBalChart(dataPoints: [String], values: [Double]) {
           
        // 1. Set ChartDataEntry
         var dataEntries: [ChartDataEntry] = []
         for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]) )
           dataEntries.append(dataEntry)
            
         }
        
         // 2. Set ChartDataSet
        let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "Structured vs. Balanced Results")
         barChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        barChartDataSet.valueFont = .systemFont(ofSize: 14)
        
        barChartDataSet.highlightEnabled = false
        //barChartDataSet.highlightColor = none
        barChartDataSet.barShadowColor = graphgray
        
        let xAxis = SugBalChartView.xAxis
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 14)
        //xAxis.granularity = 1
        xAxis.labelCount = 0
    
        let chartFormatter = SugBalChartLabelFormatter()

        for i in 0..<dataPoints.count {
            chartFormatter.stringForValue(Double(i), axis: xAxis)
        }

        SugBalChartView.xAxis.valueFormatter = chartFormatter
        
        
        let leftAxisFormatter = NumberFormatter()
        
        let leftAxis = SugBalChartView.leftAxis
        leftAxis.enabled = false
        
        leftAxis.labelPosition = .insideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 1.0
        
        let rightAxis = SugBalChartView.rightAxis
        rightAxis.enabled = false
        
        
         // 3. Set ChartData
        let barChartData = BarChartData(dataSet: barChartDataSet)
         
        let format = NumberFormatter()
        format.numberStyle = .percent
        format.percentSymbol = "%"
       
        let formatter = DefaultValueFormatter(formatter: format)
         barChartData.setValueFormatter(formatter)
        
        SugBalChartView.legend.enabled = false
        SugBalChartView.drawBarShadowEnabled = true
        SugBalChartView.doubleTapToZoomEnabled = false
        
        // 4. Assign it to the chart’s data
         SugBalChartView.data = barChartData
        
        
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

final class SugBalChartLabelFormatter: NSObject, IAxisValueFormatter {
    
    var columnLabels: [String]! = ["Structured", "Balanced"]
    
    func stringForValue( _ value: Double, axis _: AxisBase?) -> String {
        return columnLabels[Int(value)]
    }
}

