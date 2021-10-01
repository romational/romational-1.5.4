//
//  MyComparesTableViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/8/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class MyComparesTableViewController: UITableViewController, MyComparesProtocol {
    
    // download compares
    var myComparesList: NSArray = NSArray()
    
    func myComparesDownloaded(myCompares: NSArray) {
        myComparesList = myCompares
        
        tableView.reloadData()
        
    }
    

    // load view

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        // my compares
        let getMyCompares = MyCompares()
        getMyCompares.delegate = self
        getMyCompares.downloadMyCompares()
      
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myComparesList.count
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompareCell", for: indexPath) as? MyComparesTableViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue My Compares Cell.")
        }

        // Configure the cell...

        let thisCompare = myComparesList[indexPath[1]] as? MyComparesModel
        
        print (thisCompare)
        
        let userId    = thisCompare?.userId ?? 0
        var thisUserName = ""
        
        if thisCompare?.nickName != "" {
            thisUserName  = thisCompare?.nickName as? String ?? "n/a"
        }
        else {
            let firstName  = thisCompare?.firstName as? String ?? "n/a"
            let lastName  = thisCompare?.lastName as? String ?? "n/a"
            thisUserName = ("\(firstName) \(lastName)")
        }
        let userImage = thisCompare?.image as? String ?? ""
        
        let introStatusMe  = thisCompare?.introStatusMe as? String ?? "n/a"
        let romtypeStatusMe  = thisCompare?.level1StatusMe as? String ?? "n/a"
        let factorStatusMe  = thisCompare?.level2StatusMe as? String ?? "n/a"
        let fullStatusMe  = thisCompare?.level3StatusMe as? String ?? "n/a"
        
        
        let introStatusThem  = thisCompare?.introStatusThem as? String ?? "n/a"
        let romtypeStatusThem  = thisCompare?.level1StatusThem as? String ?? "n/a"
        let factorStatusThem  = thisCompare?.level2StatusThem as? String ?? "n/a"
        let fullStatusThem  = thisCompare?.level3StatusThem as? String ?? "n/a"
        
        cell.displayMyCompares(thisUserId: userId, thisUserName: thisUserName, thisUserImage: userImage, thisIntroStatusMe: introStatusMe, thisRomtypeStatusMe: romtypeStatusMe, thisFactorStatusMe: factorStatusMe, thisFullStatusMe: fullStatusMe, thisIntroStatusThem: introStatusThem, thisRomtypeStatusThem: romtypeStatusThem, thisFactorStatusThem: factorStatusThem, thisFullStatusThem: fullStatusThem)
       
        cell.upNextButton.layer.cornerRadius = 10
        cell.upNextButton.layer.masksToBounds = true
        cell.upNextButton.titleEdgeInsets = UIEdgeInsets(top: 2.0, left: 10.0, bottom: 2.0, right: 5.0)
        
        // denied statements
        if (introStatusThem == "denied" || romtypeStatusThem == "denied" || factorStatusThem == "denied" || fullStatusThem == "denied") {
            
            cell.upNextButton.layer.backgroundColor = romDarkGray.cgColor
            cell.upNextButton.setTitle("Connection Denied by Them", for: .normal)
        }
        else if (introStatusMe == "denied" || romtypeStatusMe == "denied" || factorStatusMe == "denied" || fullStatusMe == "denied") {
           
          
            cell.upNextButton.layer.backgroundColor = black.cgColor
            cell.upNextButton.setTitle("You Stopped This Connect", for: .normal)
            
        }
        
        // intro
        else if (introStatusThem == "new" || introStatusThem == "undecided") {
            cell.upNextButton.tag = userId
            cell.upNextButton.setTitle("Waiting on Their Intro Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoIntroCompare(sender:)), for: .touchUpInside)
        }
        else if (introStatusMe == "undecided" || introStatusMe == "new") {
            cell.upNextButton.layer.backgroundColor = romPink.cgColor
            cell.upNextButton.tag = userId
            cell.upNextButton.setTitle("Needs Your Intro Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoIntroCompare(sender:)), for: .touchUpInside)
        }
        
        // level 1 (romtype)
        else if (romtypeStatusThem == "new" || romtypeStatusThem == "undecided") {
            cell.upNextButton.tag = userId
            cell.upNextButton.setTitle("Waiting on Their Level 1 Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoRomtypeCompare(sender:)), for: .touchUpInside)
        }
        else if (romtypeStatusMe == "undecided" || romtypeStatusMe == "new") {
            cell.upNextButton.tag = userId
            cell.upNextButton.layer.backgroundColor = romPink.cgColor
            cell.upNextButton.setTitle("Needs Your Level 1 Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoRomtypeCompare(sender:)), for: .touchUpInside)
        }
        
        // level 2 (factors)
        else if (factorStatusThem == "new" || factorStatusThem == "undecided") {
            cell.upNextButton.tag = userId
            cell.upNextButton.setTitle("Waiting on Their Level 2 Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoFactorsCompare(sender:)), for: .touchUpInside)
        }
        else if (factorStatusMe == "undecided" || factorStatusMe == "new") {
            cell.upNextButton.tag = userId
            cell.upNextButton.layer.backgroundColor = romPink.cgColor
            cell.upNextButton.setTitle("Needs Your Level 2 Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoFactorsCompare(sender:)), for: .touchUpInside)
        }
        
        // level 3 (full)
        else if (fullStatusThem == "new" || fullStatusThem == "undecided") {
            cell.upNextButton.tag = userId
            cell.upNextButton.setTitle("Waiting on Their Level 3 Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoFullCompare(sender:)), for: .touchUpInside)
        }
        else if (fullStatusMe == "undecided" || fullStatusMe == "new") {
            cell.upNextButton.tag = userId
            cell.upNextButton.layer.backgroundColor = romPink.cgColor
            cell.upNextButton.setTitle("Needs Your Level 3 Decision", for: .normal)
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoFullCompare(sender:)), for: .touchUpInside)
        }
        
        // if everything approved
        else if (introStatusThem == "approved" && romtypeStatusThem == "approved" && factorStatusThem == "approved" && fullStatusThem == "approved" && introStatusMe == "approved" && romtypeStatusMe == "approved" && factorStatusMe == "approved" && fullStatusMe == "approved") {
            cell.upNextButton.tag = userId
            cell.upNextButton.layer.backgroundColor = romTeal.cgColor
            cell.upNextButton.setTitle("Shared Connection! View Their Information", for: .normal)
          
            cell.upNextButton.contentHorizontalAlignment = .center
            cell.upNextButton.addTarget(self, action: #selector(gotoCompareShare(sender:)), for: .touchUpInside)
            
        }
        
        cell.introButton.tag = userId
        cell.introButton.addTarget(self, action: #selector(gotoIntroCompare(sender:)), for: .touchUpInside)
        
        cell.romtypeButton.tag = userId
        cell.romtypeButton.addTarget(self, action: #selector(gotoRomtypeCompare(sender:)), for: .touchUpInside)
        
        cell.factorsButton.tag = userId
        cell.factorsButton.addTarget(self, action: #selector(gotoFactorsCompare(sender:)), for: .touchUpInside)
        
        cell.fullButton.tag = userId
        cell.fullButton.addTarget(self, action: #selector(gotoFullCompare(sender:)), for: .touchUpInside)
        
        return cell
    }

    // compare links
    // compare links
    @objc func gotoIntroCompare(sender: UIButton){
        let compareUserId = sender.tag
        
        print (compareUserId)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareIntro") as! CompareIntroViewController
        
        destination.compareUserId = String(compareUserId)
        destination.qrcodeString = "https://www.romational.com?userId=\(compareUserId)"
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @objc func gotoRomtypeCompare(sender: UIButton){
        let compareUserId = sender.tag
        
        print (compareUserId)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL1") as! CompareLevelOneViewController
        
        destination.compareUserId = String(compareUserId)
        destination.qrcodeString = "https://www.romational.com?userId=\(compareUserId)"
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
    }
    
    @objc func gotoFactorsCompare(sender: UIButton){
        let compareUserId = sender.tag
        print (compareUserId)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL2") as! CompareLevelTwoViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @objc func gotoFullCompare(sender: UIButton){
        let compareUserId = sender.tag
        print (compareUserId)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareL3") as! CompareLevelThreeViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    @objc func gotoCompareShare(sender: UIButton){
        let compareUserId = sender.tag
        print (compareUserId)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareShareInfo") as! CompareShareInfoViewController
        
        destination.compareUserId = String(compareUserId)
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
}
