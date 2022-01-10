//
//  AllFactorsCollectionViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/30/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FactorCell"


class AllFactorsCollectionViewController: UICollectionViewController, FactorListProtocol, MyFactorsProtocol{
    
    @IBAction func unwindToAllFactors(_ sender: UIStoryboardSegue) {
    }
    

    @IBOutlet var allFactorsView: UICollectionView!
    
    var factorList : NSArray = NSArray()
    
    func factorsDownloaded(factors: NSArray) {
        factorList = factors
        
        //print (factors)
        
        collectionView?.reloadData()
        //self.removeSpinner()
        
    }
    
    // bring in myFactors
    var myFactors: NSArray = NSArray()
    
    func myFactorAnswersDownloaded(factors: NSArray) {
        myFactors = factors
        
        //print (myFactors)
        
        let factorList = FactorList()
        factorList.delegate = self
        factorList.downloadItems()
        
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

       // self.showSpinner(onView: self.view)
        
        let myFactorAnswers = MyFactorAnswers()
        myFactorAnswers.delegate = self
        myFactorAnswers.downloadMyFactorAnswers(userid: userId)
        
        self.collectionView!.backgroundColor = UIColor.clear
        
        
        allFactorsView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //allFactorsView.backgroundColor = UIColor(patternImage: UIImage(named: "gray-clouds.jpg")!)
        
        // Do any additional setup after loading the view.
        
        collectionView?.reloadData()
    }

  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return factorList.count
    }

   // let defaults = UserDefaults.standard
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AllFactorsCollectionViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue AllFactorCell.")
        }
    
        // Configure the cell
    
        let thisFactor = factorList[indexPath[1]] as? FactorListModel
        var qstatus = String()
        
        let question = ("TQ\(indexPath[1])")
        
        let myAnswer = myFactors[indexPath[1]] as? MyFactorAnswersModel
        
        //print (myAnswer)
        
        let thisAnswer = myAnswer?.answerId ?? "0"
     
        if (thisAnswer != "0") && (thisAnswer != nil){
            qstatus = "done"
        } else {
            qstatus = "undone"
        }
        //print (qstatus)
        
        let FQ = indexPath[1] + 1
        
        let factorId = thisFactor?.id 
        let factorName = (thisFactor?.name)!
        let factorImage = (thisFactor?.image)!
     
     
        cell.displayFactorIcons(fq: FQ, factor: factorName, image: factorImage, status:qstatus)
        //print (factorName)
        //cell.factorIcon.size = 60
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 10
     }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 20
     }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
 */
    
    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     
        let thisFactor = factorList[indexPath[1]] as? FactorListModel
        //print (thisFactor)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
        
        factorOpt = thisFactor!.order!
        return true
    }
    

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
