//
//  MyRomtypeDataCollectionViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 5/6/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MyRomtypeDataCell"

class MyRomtypeDataCollectionViewController: UICollectionViewController, MyRomtypeDataProtocol {
    
    
    var romtypeData: NSArray = NSArray()
    
    func myRomtypeDataDownloaded(myRomtypeData: NSArray) {
        
        romtypeData = myRomtypeData
        print (romtypeData)
        
        collectionView?.reloadData()
    }
    
    
    
    
    // MARK: view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let getRomtypeData = MyRomtypeData()
        getRomtypeData.delegate = self
        getRomtypeData.downloadMyRomtypeData(userid: userId)
        
    
    }

    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return romtypeData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRomtypeDataCell", for: indexPath) as? MyRomtypeDataCollectionViewCell else {
           
            fatalError("Unable to dequeue My Romtype Data Cell.")
        }
        
        let thisRTQ = romtypeData[indexPath[1]] as! MyRomtypeDataModel
        //print (thisRTQ)
        
        let rtqName = thisRTQ.name ?? "empty"
        let rtqAnswer = thisRTQ.answer ?? "none"
        let rtqImage = thisRTQ.image ?? "none"
        let rtqOrder = thisRTQ.order ?? 1
        
        cell.printRTQCells(order: rtqOrder, question: rtqName, answer: rtqAnswer, image: rtqImage)
        
        // gesture recognizer for image click
        cell.rtqText.isUserInteractionEnabled = true
        
        let recognizer = RomcellGestureRecognizer(target: self, action: #selector(self.clickMe), qid: rtqOrder)
        cell.rtqText.addGestureRecognizer(recognizer)
        
        
    
        return cell
    }

 
    @objc func clickMe(gestureRecognizer: RomcellGestureRecognizer) {
       
        goBack = "MyRomtypeData"
        
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
       let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
       destination.modalPresentationStyle = .fullScreen
       self.present(destination, animated: true)
       
        romtypeOpt = gestureRecognizer.qid!
       
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
           let thisRTQ = romtypeData[indexPath[1]] as! MyRomtypeDataModel
           print (thisRTQ)
           
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           let destination = storyboard.instantiateViewController(withIdentifier: "RomtypeQuestions") as! RomtypeViewController
        destination.modalPresentationStyle = .fullScreen
           self.present(destination, animated: true)
        
            romtypeOpt = thisRTQ.order!
           return true
 
       }
       */
    
   
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           
       }
   

}

// for isolated image click
class RomcellGestureRecognizer : UITapGestureRecognizer {
    
    var qid : Int?
    // any more custom variables here
    
    init(target: AnyObject?, action: Selector, qid : Int) {
        super.init(target: target, action: action)
        
        self.qid = qid
    }
    
}

