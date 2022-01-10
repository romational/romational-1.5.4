//
//  AllRomtypesCollectionViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/30/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RTQCell"




class AllRomtypesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, RTQListProtocol, MyRomtypeAnswersProtocol{
    
    
    @IBAction func unwindToAllRomtypes(_ sender: UIStoryboardSegue) {
    }
    
    
    
    var rtqList : NSArray = NSArray()
    
    func RTQListDownloaded(rtqlist: NSArray) {
        rtqList = rtqlist
        
        //print (rtqList)
        
        collectionView?.reloadData()
        
        //self.removeSpinner()
        
    }
    
    
    @IBOutlet var allRomtypesView: UICollectionView!
    

    // bring in myRomtypes
    var myRomtypes: NSArray = NSArray()
    
    func myRomtypeAnswersDownloaded(romtypeAnswers: NSArray) {
        myRomtypes = romtypeAnswers
        //print (myRomtypes)
        
        let rtqList = RTQList()
        rtqList.delegate = self
        rtqList.downloadRTQList()
        
        collectionView?.reloadData()
        
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

        //self.showSpinner(onView: self.view)
      
        let myRomtypeAnswers = MyRomtypeAnswers()
        myRomtypeAnswers.delegate = self
        myRomtypeAnswers.downloadMyRomtypeAnswers(userid: userId)
        
        
        allRomtypesView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.collectionView!.backgroundColor = UIColor.clear
        
        //allRomtypesView.backgroundColor = UIColor(patternImage: UIImage(named: "gray-clouds.jpg")!)
        
        // Do any additional setup after loading the view.
        collectionView?.reloadData()
    }

  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return rtqList.count
    }

   // let defaults = UserDefaults.standard
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AllRomtypesCollectionViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue AllRomtypeCell.")
        }
    
        // Configure the cell
    
        let thisRomtype = rtqList[indexPath[1]] as? RTQListModel
        var qstatus = String()
        
        let question = ("TQ\(indexPath[1])")
        
        let myAnswer = myRomtypes[indexPath[1]] as? MyRomtypeAnswersModel
        
        //print (myAnswer)
        
        let thisAnswer = myAnswer?.answerId ?? "0"
        
        if (thisAnswer != "") {
            qstatus = "done"
        } else {
            qstatus = "undone"
        }
        
        let FQ = indexPath[1] + 1
        
        let romtypeId = thisRomtype?.id 
        let romtypeTitle = thisRomtype?.name! ?? "n/a"
        //let romtypeName = ("\(String(describing: romtypeTitle))")
        let romtypeImage = thisRomtype?.image ?? "profile.jpg"
        
        
        cell.displayRomtypeIcons(fq: FQ, romtype: romtypeTitle, image: romtypeImage, status:qstatus)
        //print (romtypeName)
        return cell
        
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     
        let thisRomtype = rtqList[indexPath[1]] as? RTQListModel
        //print (thisRomtype)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
        romtypeOpt = thisRomtype!.order!
        //print (romtypeOpt)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

