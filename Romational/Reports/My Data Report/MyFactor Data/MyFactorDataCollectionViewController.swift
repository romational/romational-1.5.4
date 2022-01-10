//
//  FactorCollectionViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/18/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MyFactorDataCell"

class MyFactorDataCollectionViewController: UICollectionViewController, MyFactorDataProtocol {
   
    // MARK: bring in factors and questions
    
    
    var factorData : NSArray = NSArray()

    func myFactorDataDownloaded(myFactorData: NSArray) {
        
        factorData = myFactorData
               
        print (factorData)
        
        collectionView?.reloadData()
    }
    


    
    // MARK: view did load

    override func viewDidLoad() {
        super.viewDidLoad()

        let getMyFactorData = MyFactorData()
        getMyFactorData.delegate = self
    
        getMyFactorData.downloadMyFactorData(userid: userId)
   
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return factorData.count
        //return 5
    }

    
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFactorDataCell", for: indexPath) as? MyFactorDataCollectionViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue My Factor Data Cell.")
        }
     
        
        let thisFactor = factorData[indexPath[1]] as! MyFactorDataModel
        
       // let factorId        = thisFactor.id ?? 0
        let factorOrder     = thisFactor.order ?? 1
        let factorName      = thisFactor.name ?? "empty"
        let factorImage     = thisFactor.image ?? "empty"
        let factorAnswer    = thisFactor.answer ?? "empty"
        let factorSelectivity = thisFactor.selectivity ?? 0.00
       
           
        cell.displayFactorResults(factor: factorName, order: String(factorOrder), image: factorImage, answer: factorAnswer, selectivity: factorSelectivity)
        
        //cell.factorBkgd.layer.cornerRadius = 45
        
        cell.factorImage.isUserInteractionEnabled = true
        let recognizer = FactorCellGestureRecognizer(target: self, action: #selector(self.clickMe), qid: factorOrder)
        cell.factorImage.addGestureRecognizer(recognizer)
        
        cell.factorName.isUserInteractionEnabled = true
        let recognizer2 = FactorCellGestureRecognizer(target: self, action: #selector(self.clickMe), qid: factorOrder)
        cell.factorName.addGestureRecognizer(recognizer2)
        
        
        return cell
    }

    
    @objc func clickMe(gestureRecognizer: RomcellGestureRecognizer) {
       
        goBack = "MyFactorData"
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
       destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
       
        factorOpt = gestureRecognizer.qid!
       
    }
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     
         let thisFactor = factorData[indexPath[1]] as! MyFactorDataModel
        print (thisFactor)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
    destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
        
        factorOpt = thisFactor.order!
        return true
    }
    */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
  
   

}

// for isolated image click
class FactorCellGestureRecognizer : UITapGestureRecognizer {
    
    var qid : Int?
    // any more custom variables here
    
    init(target: AnyObject?, action: Selector, qid : Int) {
        super.init(target: target, action: action)
        
        self.qid = qid
    }
    
}
