//
//  MyTypeIsTableViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/7/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class RomtypeTableViewController: UITableViewController, RomtypeWeightsProtocol {
 

    @IBOutlet var listTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //typeScore()
        
        self.tableView.rowHeight = 100.0
        
        self.tableView.isScrollEnabled = false
        
        self.tableView.backgroundColor = UIColor.clear
        
        /*
        let romtypeList = RomtypeList()
        romtypeList.delegate = self
        romtypeList.downloadRomtypes()
        */
        
        let romtypeWeights = RomtypeWeights()
        romtypeWeights.delegate = self
        romtypeWeights.downloadWeights(userid: userId)
        
    }

    /*
    var romTypes: NSArray = NSArray()
    
    func romtypesDownloaded(romtypes: NSArray) {
        
        romTypes = romtypes
        self.listTableView.reloadData()
    }
    */
    
    
    var romWeights: NSArray = NSArray()
    
    func weightsDownloaded(weights: NSArray) {
        
        print (romWeights)
        romWeights = weights
        self.listTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return romWeights.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Retrieve cell
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        // Get the location to be shown
        //let item: RomtypeListModel = romTypes[indexPath.row] as! RomtypeListModel
       
        let weight = romWeights[indexPath.row] as! RomtypeWeightsModel
        
        print(weight.type)
        
        let rowNumber : Int = indexPath.row
        
        // clear the dang cell
        myCell.contentView.backgroundColor = UIColor.clear
        myCell.backgroundColor = UIColor.clear
        myCell.layer.backgroundColor = UIColor.clear.cgColor
        
       
        // order of romType
        let orderNumber = UILabel(frame: CGRect(x: 0, y: 40, width: 30, height: 20))
        orderNumber.text = "#\(rowNumber+1)"
        myCell.contentView .addSubview(orderNumber)
        
        let iconImageView = UIImageView()
        iconImageView.frame = CGRect(x: 30, y: 20, width: 100, height: 50)
        
        let imageName = "\(weight.type!)-v2.png"
        
        if let cellImage = UIImage(named: imageName) {
            
            iconImageView.image = cellImage
        }
        
        iconImageView.isUserInteractionEnabled = true
        
        let recognizer = CustomGestureRecognizer(target: self, action: #selector(self.imageTap), imgName: weight.type!)
        // Add gesture recognizer to your image view
        iconImageView.addGestureRecognizer(recognizer)
        myCell.contentView .addSubview(iconImageView)
        
        // background bar
        let highlightBar = UIView(frame: CGRect(x: 140, y: 25, width: 130, height: 40))
        highlightBar.backgroundColor = graphgray
        highlightBar.layer.zPosition = -1
        myCell.contentView .addSubview(highlightBar)
        
        // calculate width
        var ratio = 0.0
        
        if weight.percent != nil {
            let percent = Float(weight.percent!)
            ratio = Double(percent / 100)
            //print (ratio)
        }
        
        // add ratio bar view to selectedBackgroundView,
        let selectView = UIView(frame: CGRect(x: 140, y: 25, width: Int(130 * ratio), height: 40))
        
        selectView.backgroundColor = black
        //selectView.layer.zPosition = 1
        myCell.contentView .addSubview(selectView)
        
        
        // cell labels
        myCell.textLabel!.text = ("\(weight.percent!)%")
        myCell.textLabel!.textColor = black
        
        myCell.textLabel?.textAlignment = .right

        
        return myCell
    
    }
    
    @objc func imageTap(gestureRecognizer: CustomGestureRecognizer)
    {
        let tapImg = gestureRecognizer.view as! UIImageView
        print (tapImg.image)
        
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "RomtypeInfo") as! RomtypeInfoViewController
        secondViewController.viewRomTypeImage = tapImg.image!
        secondViewController.viewRomTypeName = gestureRecognizer.imgName!
        
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true)
    }
    


}

class CustomGestureRecognizer : UITapGestureRecognizer {
    
    var imgName : String?
    // any more custom variables here
    
    init(target: AnyObject?, action: Selector, imgName : String) {
        super.init(target: target, action: action)
        
        self.imgName = imgName
    }
    
}

