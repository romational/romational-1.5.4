//
//  RomtypeReportViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/19/20.
//  Copyright © 2020 Paholo Inc. All  rights reserved.
//

import UIKit
//import Charts
import SceneKit


class RomtypeReportViewController: UIViewController, MyRomtypeProtocol, RomtypeWeightsProtocol {
   
    
    // bring in romtype info
    var myRomtype = NSArray()
    var thisRomtype = ""
    var romLink = ""
    
    func myRomtypeDownloaded(myRomtypeInfo: NSArray) {
        
        myRomtype = myRomtypeInfo
        
        print (myRomtype)
        
        if let first = myRomtype[0] as? [String: Any] {
    
            thisRomtype = (first["type"] as? String)!
            
            let firstImage  = first["image"] as? String
            let firstName   = first["name"] as? String
           
            let firstUrl    = first["url"] as? String
            let firstInfo   = first["info"] as? String
            let firstDefine = first["define"] as? String
            
            romLink = firstUrl!
            myTypeUrl.setTitle("Learn More", for: .normal)
            //myTypeUrl.addTarget(self, action: Selector(("didTapLink")), for: .touchUpInside)
        
            myTypeImage.image = UIImage(named: "\(firstImage!)")
            myTypeImage.addBkgdShadowToImage(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 80, shadowSize: 4)
            myTypeName.text = firstName!.uppercased()
            //myTypeSummary.text = firstDefine!
            myTypeInfo.text = firstInfo!
            //let second = myRomtype[1] as? Array<Any>
        }
        
        // tap gesture
        let tapMe = CustomTapGesture(target: self, action: #selector(gotoRomtypeInfo))

        tapMe.var1 = thisRomtype
        
        print (thisRomtype)
        //tap.var2 = Int(dateId)!
        
        myTypeImage.isUserInteractionEnabled = true
        myTypeImage.addGestureRecognizer(tapMe)
        
        let sugBkgd = UIView(frame: CGRect(x: 80, y: 0, width: 40, height: 300))
        sugBkgd.layer.backgroundColor = romLightGray.cgColor
        sugBkgd.applyViewGradient(colors: [romLightGray.cgColor, white.cgColor, romLightGray.cgColor], radius: 40, direction: "angled22")
        sugBkgd.layer.cornerRadius = 20
        sChart.addSubview(sugBkgd)
        
        let balBkgd = UIView(frame: CGRect(x: 180, y: 0, width: 40, height: 300))
        balBkgd.layer.backgroundColor = romLightGray.cgColor
        balBkgd.layer.cornerRadius = 20
        balBkgd.applyViewGradient(colors: [romLightGray.cgColor, white.cgColor, romLightGray.cgColor], radius: 40, direction: "angled45")
        sChart.addSubview(balBkgd)
        
        let casBkgd = UIView(frame: CGRect(x: 50, y: 0, width: 40, height: 300))
        casBkgd.layer.backgroundColor = romLightGray.cgColor
        casBkgd.layer.cornerRadius = 20
        casBkgd.applyViewGradient(colors: [romLightGray.cgColor, white.cgColor, romLightGray.cgColor], radius: 40, direction: "horizontal")
        mChart.addSubview(casBkgd)
        
        let datBkgd = UIView(frame: CGRect(x: 130, y: 0, width: 40, height: 300))
        datBkgd.layer.backgroundColor = romLightGray.cgColor
        datBkgd.layer.cornerRadius = 20
        datBkgd.applyViewGradient(colors: [romLightGray.cgColor, white.cgColor, romLightGray.cgColor], radius: 40, direction: "horizontal")
        mChart.addSubview(datBkgd)
        
        let comBkgd = UIView(frame: CGRect(x: 210, y: 0, width: 40, height: 300))
        comBkgd.layer.backgroundColor = romLightGray.cgColor
        comBkgd.layer.cornerRadius = 20
        comBkgd.applyViewGradient(colors: [romLightGray.cgColor, white.cgColor, romLightGray.cgColor], radius: 40, direction: "horizontal")
        mChart.addSubview(comBkgd)
        
        
        if let stats = myRomtype[2] as? [String: Any] {
            
            print (stats)
            
            // structure bars
            let sug = stats["sug"] as! String
            let bal = stats["bal"] as! String
            
            let sugH = Int(300 * Double(sug)!)
            
            let sugBar = UIView(frame: CGRect(x: 80, y: 300 - sugH, width: 40, height: sugH ))
            sugBar.layer.backgroundColor = romPurple.cgColor
            sugBar.layer.cornerRadius = 20
            
            sChart.addSubview(sugBar)
            
            let sugBubble = UILabel(frame: CGRect(x: 80, y: 0, width: 40, height: 40 ))
            sugBubble.layer.backgroundColor = white.cgColor
            let sugPercent = Int(Double(sug)! * 100)
            sugBubble.text = ("\(sugPercent)%")
            sugBubble.layer.cornerRadius = 20
            sugBubble.textColor = romDarkGray
            sugBubble.font = UIFont(name:"HelveticaNeue", size: 14.0)
            sugBubble.textAlignment = .center
            sugBubble.layer.opacity = 0.50
            
            sChart.addSubview(sugBubble)
            
            let sugTitle = UILabel(frame: CGRect(x: 60, y: 300, width: 70, height: 20 ))
            sugTitle.font = UIFont(name:"HelveticaNeue", size: 14.0)
            sugTitle.text = "Structured"
            sugTitle.textAlignment = .center
            sugTitle.textColor = romDarkGray
            sChart.addSubview(sugTitle)
            
            // balance bars
            let balH = Int(300 * Double(bal)!)
            
            let balBar = UIView(frame: CGRect(x: 180, y: 300 - balH, width: 40, height: balH))
                                
            balBar.layer.backgroundColor = romRed.cgColor
            balBar.layer.cornerRadius = 20
            
            sChart.addSubview(balBar)
            
            let balBubble = UILabel(frame: CGRect(x: 180, y: 0, width: 40, height: 40 ))
            balBubble.layer.backgroundColor = white.cgColor
            let balPercent = Int(Double(bal)! * 100)
            balBubble.text = ("\(balPercent)%")
            balBubble.layer.cornerRadius = 20
            balBubble.layer.opacity = 0.50
            balBubble.textColor = romDarkGray
            balBubble.font = UIFont(name:"HelveticaNeue", size: 14.0)
            balBubble.textAlignment = .center
            
            sChart.addSubview(balBubble)
            
            let balTitle = UILabel(frame: CGRect(x: 170, y: 300, width: 60, height: 20 ))
            balTitle.font = UIFont(name:"HelveticaNeue", size: 14.0)
            balTitle.text = "Balanced"
            balTitle.textAlignment = .center
            balTitle.textColor = romDarkGray
            sChart.addSubview(balTitle)
            
            // mindset chart
            
            let cas = stats["cas"] as! String
            let dat = stats["dat"] as! String
            let com = stats["com"] as! String
            
            let casH = Int(260 * Double(cas)!)
            let casBar = UIView(frame: CGRect(x: 50, y: 300 - casH, width: 40, height: casH))
            casBar.layer.backgroundColor = romBlueCas.cgColor
            casBar.layer.cornerRadius = 20
            
            mChart.addSubview(casBar)
            
           
            let casBubble = UILabel(frame: CGRect(x: 50, y: 0, width: 40, height: 40 ))
            casBubble.layer.backgroundColor = white.cgColor
            let casPercent = Int(Double(cas)! * 100)
            casBubble.text = ("\(casPercent)%")
            casBubble.layer.cornerRadius = 20
            casBubble.layer.opacity = 0.50
            casBubble.textColor = romDarkGray
            casBubble.font = UIFont(name:"HelveticaNeue", size: 14.0)
            casBubble.textAlignment = .center
            
            mChart.addSubview(casBubble)
            
            let casTitle = UILabel(frame: CGRect(x: 40, y: 300, width: 60, height: 20 ))
            casTitle.font = UIFont(name:"HelveticaNeue", size: 14.0)
            casTitle.text = "Casual"
            casTitle.textAlignment = .center
            casTitle.textColor = romDarkGray
            mChart.addSubview(casTitle)
            
            
            
            let datH = Int(260 * Double(dat)!)
            let datBar = UIView(frame: CGRect(x: 130, y: 300 - datH, width: 40, height: datH))
            datBar.layer.backgroundColor = romBlueDat.cgColor
            datBar.layer.cornerRadius = 20
            
            mChart.addSubview(datBar)
            
            let datBubble = UILabel(frame: CGRect(x: 130, y: 0, width: 40, height: 40 ))
            datBubble.layer.backgroundColor = white.cgColor
            let datPercent = Int(Double(dat)! * 100)
            datBubble.text = ("\(datPercent)%")
            datBubble.layer.cornerRadius = 20
            datBubble.layer.opacity = 0.50
            datBubble.textColor = romDarkGray
            datBubble.font = UIFont(name:"HelveticaNeue", size: 14.0)
            datBubble.textAlignment = .center
            
            mChart.addSubview(datBubble)
            
            let datTitle = UILabel(frame: CGRect(x: 120, y: 300, width: 60, height: 20 ))
            datTitle.font = UIFont(name:"HelveticaNeue", size: 14.0)
            datTitle.text = "Dating"
            datTitle.textAlignment = .center
            datTitle.textColor = romDarkGray
            mChart.addSubview(datTitle)
            
        
            let comH = Int(260 * Double(com)!)
            let comBar = UIView(frame: CGRect(x: 210, y: 300 - comH, width: 40, height: comH))
            comBar.layer.backgroundColor = romBlueCom.cgColor
            comBar.layer.cornerRadius = 20
            
            mChart.addSubview(comBar)
            
            let comBubble = UILabel(frame: CGRect(x: 210, y: 0, width: 40, height: 40 ))
            comBubble.layer.backgroundColor = white.cgColor
            let comPercent = Int(Double(com)! * 100)
            comBubble.text = ("\(comPercent)%")
            comBubble.layer.cornerRadius = 20
            comBubble.layer.opacity = 0.50
            comBubble.textColor = romDarkGray
            comBubble.font = UIFont(name:"HelveticaNeue", size: 14.0)
            comBubble.textAlignment = .center
            
            mChart.addSubview(comBubble)
            
            let comTitle = UILabel(frame: CGRect(x: 190, y: 300, width: 80, height: 20 ))
            comTitle.font = UIFont(name:"HelveticaNeue", size: 14.0)
            comTitle.text = "Committed"
            comTitle.textAlignment = .center
            comTitle.textColor = romDarkGray
            mChart.addSubview(comTitle)
        }
        
    }
    
    var romWeights: NSArray = NSArray()
    
    func weightsDownloaded(weights: NSArray) {
        
        romWeights = weights
        
        //print (romWeights)
        
        var ballPositions = [Double]()
        
        var i = 0
        for col in cols {
            
            let thisWeight = romWeights[i] as! RomtypeWeightsModel
            
            //print (thisWeight.percent!)
            let thisPercent = Double(thisWeight.percent!) / 100.0
            //print (thisPercent)
            let lineHeight = 240 - (thisPercent * 240)
            ballPositions.append(lineHeight)
            
            let gaugeLine = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: Int(lineHeight)))
            
            gaugeLine.layer.backgroundColor = romLightGray.cgColor
            
            gaugeLine.applyViewGradient(colors: [romLightGray.cgColor,  white.cgColor, romLightGray.cgColor], radius: 10, direction: "horizontal")
            
            col.addSubview(gaugeLine)
            
            colTypes[i].text = thisWeight.type!
            colPercents[i].text = ("\(thisWeight.percent!)%")
            
            // tap gesture
            let tap = CustomTapGesture(target: self, action: #selector(gotoRomtypeInfo))

            tap.var1 = thisWeight.type!
            //tap.var2 = Int(dateId)!
            
            colTypes[i].isUserInteractionEnabled = true
            colTypes[i].addGestureRecognizer(tap)
            
            //drawCircle(imgView: ball)
            i = i + 1
        }
        
        var lineX = 35.0
        //let lineYs = [, 20, 100, 30, 200, 150]
        
        /*
        var b = 0
        ballPositions.forEach { bPos in
            
            //lineX = lineX + 40
            lineX = Double(cols[b].frame.origin.x)
            
            let ballImg = UIImageView(frame: CGRect(x: Int(lineX) - Int(12.5), y: Int(bPos)+5, width: 30, height: 30))
            ballImg.image = UIImage(named: "ballKnob-200x200.png")
            
            drawPins.addSubview(ballImg)
            b = b + 1
        }
         */
        
    }
    
    // when a question is chosen (tapped)
    @objc func gotoRomtypeInfo(sender : CustomTapGesture) {

        print (sender.var1)
        //print (sender.var2)
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "RomtypeInfo") as! RomtypeInfoViewController
        //secondViewController.viewRomTypeImage = tapImg.image!
        secondViewController.viewRomTypeName = sender.var1
        
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: false)
        
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
    
    
    
    // sub nav
    
    @IBAction func foundationButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FoundationReport") as! RomtypeFoundationViewController
        
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
    
        let pageInfo = VCS["RomtypeReport"] as! VCSInfoModel
        // setup info popup
        
        let popupInfo   = pageInfo.popup ?? "n/a"
        let popupTitle  = pageInfo.popupTitle ?? "About My RomType Score"
        let popupButton = pageInfo.popupButton ?? "Ok, Got It"
        
        
        let alertController:UIAlertController = UIAlertController(title: popupTitle, message: popupInfo, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: popupButton, style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // view variables
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var romtypeReportView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var myTypeImage: UIImageView!
    @IBOutlet weak var myTypeName: UILabel!
    @IBOutlet weak var myTypeInfo: UITextView!
    @IBOutlet weak var myTypeUrl: UIButton!
    @IBOutlet weak var myTypeSummary: UITextView!
    
    // for link urls

    @IBAction func openRomLink(_ sender: Any) {
        UIApplication.shared.open(URL(string: romLink)!)
    }
    
    @IBOutlet weak var drawPins: UIView!
    
    @IBOutlet weak var viewAnswersButton: UIButton!
    @IBAction func gotoMyAnswers(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyRomtypeData") as! MyRomtypeDataViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    
    }
    
    
    @IBOutlet weak var startFlexButton: UIButton!
    
    @IBAction func startFlexScore(_ sender: Any) {
    
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "FQIntro") as! FQIntroViewController
        
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: false, completion: nil)
    }
    
    @IBOutlet weak var col1: UIView!
    @IBOutlet weak var col2: UIView!
    @IBOutlet weak var col3: UIView!
    @IBOutlet weak var col4: UIView!
    @IBOutlet weak var col5: UIView!
    @IBOutlet weak var col6: UIView!
    
    var cols = [UIView]()
    
    
    @IBOutlet weak var colType1: UILabel!
    @IBOutlet weak var colType2: UILabel!
    @IBOutlet weak var colType3: UILabel!
    @IBOutlet weak var colType4: UILabel!
    @IBOutlet weak var colType5: UILabel!
    @IBOutlet weak var colType6: UILabel!
    
    var colTypes = [UILabel]()
    
    
    @IBOutlet weak var colPercent1: UILabel!
    @IBOutlet weak var colPercent2: UILabel!
    @IBOutlet weak var colPercent3: UILabel!
    @IBOutlet weak var colPercent4: UILabel!
    @IBOutlet weak var colPercent5: UILabel!
    @IBOutlet weak var colPercent6: UILabel!
    
    var colPercents = [UILabel]()
    
    
    @IBOutlet weak var sChart: UIView!
    
    @IBOutlet weak var sGrid1: UIView!
    @IBOutlet weak var sGrid2: UIView!
    @IBOutlet weak var sGrid3: UIView!
    @IBOutlet weak var sGrid4: UIView!
    @IBOutlet weak var sGrid5: UIView!
    @IBOutlet weak var sGrid6: UIView!
    @IBOutlet weak var sGrid7: UIView!
    @IBOutlet weak var sGrid8: UIView!
    @IBOutlet weak var sGrid9: UIView!
    @IBOutlet weak var sGrid10: UIView!
    
    var sGrids = [UIView]()
    
    
    @IBOutlet weak var mChart: UIView!
    
    @IBOutlet weak var mGrid1: UIView!
    @IBOutlet weak var mGrid2: UIView!
    @IBOutlet weak var mGrid3: UIView!
    @IBOutlet weak var mGrid4: UIView!
    @IBOutlet weak var mGrid5: UIView!
    @IBOutlet weak var mGrid6: UIView!
    @IBOutlet weak var mGrid7: UIView!
    @IBOutlet weak var mGrid8: UIView!
    @IBOutlet weak var mGrid9: UIView!
    @IBOutlet weak var mGrid10: UIView!
    
    var mGrids = [UIView]()
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        scrollView.isScrollEnabled = true
        
        // side swiping
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        //let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        //leftSwipe.direction = .left
        //rightSwipe.direction = .right

        //view.addGestureRecognizer(leftSwipe)
        //view.addGestureRecognizer(rightSwipe)
        
        
        // download romtype info
        let getMyRomtype = MyRomtype()
        getMyRomtype.delegate = self
        getMyRomtype.downloadMyRomtype(userid: userId)
 
        // download romtype weights
        let romtypeWeights = RomtypeWeights()
        romtypeWeights.delegate = self
        romtypeWeights.downloadWeights(userid: userId)
        
        // chart cols
        cols.append(col1)
        cols.append(col2)
        cols.append(col3)
        cols.append(col4)
        cols.append(col5)
        cols.append(col6)

        colTypes.append(colType1)
        colTypes.append(colType2)
        colTypes.append(colType3)
        colTypes.append(colType4)
        colTypes.append(colType5)
        colTypes.append(colType6)
        
        colPercents.append(colPercent1)
        colPercents.append(colPercent2)
        colPercents.append(colPercent3)
        colPercents.append(colPercent4)
        colPercents.append(colPercent5)
        colPercents.append(colPercent6)
        
        // structure
        sGrids.append(sGrid1)
        sGrids.append(sGrid2)
        sGrids.append(sGrid3)
        sGrids.append(sGrid4)
        sGrids.append(sGrid5)
        sGrids.append(sGrid6)
        sGrids.append(sGrid7)
        sGrids.append(sGrid8)
        sGrids.append(sGrid9)
        sGrids.append(sGrid10)
        
        sGrids.forEach { sGrid in
            sGrid.layer.addBorder(edge: .bottom, color: romLightGray, thickness: 1)
        }
        
        // mindset
        
        mGrids.append(mGrid1)
        mGrids.append(mGrid2)
        mGrids.append(mGrid3)
        mGrids.append(mGrid4)
        mGrids.append(mGrid5)
        mGrids.append(mGrid6)
        mGrids.append(mGrid7)
        mGrids.append(mGrid8)
        mGrids.append(mGrid9)
        mGrids.append(mGrid10)
        
        
        mGrids.forEach { mGrid in
            mGrid.layer.addBorder(edge: .bottom, color: romLightGray, thickness: 1)
        }
        
        
        // romtype url button link
        myTypeUrl.layer.masksToBounds = false
        myTypeUrl.layer.shadowColor = romDarkGray.cgColor
        myTypeUrl.layer.shadowOpacity = 0.3
        myTypeUrl.layer.shadowOffset = CGSize(width: 4, height: 4)
        myTypeUrl.layer.shadowRadius = 4
        myTypeUrl.layer.cornerRadius = 30
        
        
        // style bottom buttons
        viewAnswersButton.layer.masksToBounds = false
        viewAnswersButton.layer.shadowColor = romDarkGray.cgColor
        viewAnswersButton.layer.shadowOpacity = 0.3
        viewAnswersButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        viewAnswersButton.layer.shadowRadius = 4
        viewAnswersButton.layer.cornerRadius = 30
        
        startFlexButton.layer.masksToBounds = false
        startFlexButton.layer.shadowColor = romDarkGray.cgColor
        startFlexButton.layer.shadowOpacity = 0.3
        startFlexButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        startFlexButton.layer.shadowRadius = 4
        startFlexButton.layer.cornerRadius = 30
        
        
        
    }
    
    
    /* this is to fix the 2nd navigation 10px gap issue
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         if #available(iOS 13.0, *) {
              navigationController?.navigationBar.setNeedsLayout()
         }
    }
    */
    
   

    // in view functions
     
     @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
             
         if (sender.direction == .left) {
            print("Swipe Left")
             //let labelPosition = CGPoint(x: testName.frame.origin.x - 50.0, y: testName.frame.origin.y)
             //testName.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: testName.frame.size.width, height: testName.frame.size.height)
             self.foundationButton((Any).self)
             
         }
             
         if (sender.direction == .right) {
             print("Swipe Right")
            // let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
             //swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
             self.mindsetButton((Any).self)
         }
     }
    
    
    func drawCircle(imgView: UIImageView) {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))

        let img = renderer.image { ctx in
            let rect = CGRect(x: 5, y: 5, width: 30, height: 30)

            // 6
            ctx.cgContext.setFillColor(UIColor.blue.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(1)

            ctx.cgContext.addEllipse(in: rect)
            ctx.cgContext.drawPath(using: .fillStroke)
        }

        imgView.image = img
    }
    
    func drawLines(imgView: UIImageView) {
        // 1
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))

        let img = renderer.image { ctx in
            // 2
            ctx.cgContext.move(to: CGPoint(x: 20.0, y: 20.0))
            ctx.cgContext.addLine(to: CGPoint(x: 260.0, y: 230.0))
            ctx.cgContext.addLine(to: CGPoint(x: 100.0, y: 200.0))
            ctx.cgContext.addLine(to: CGPoint(x: 20.0, y: 20.0))

            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)

            // 3
            ctx.cgContext.strokePath()
        }

        imgView.image = img
    }
    
    
}


