//
//  FactorAnswerTableViewController.swift
//  Charts
//
//  Created by Nicholas Zen Paholo on 4/23/20.
//

import UIKit

class FactorAnswerTableViewController: UITableViewController, MyRankedFactorsProtocol {
    
    
      // bring in myFactors
      var myRankedFactors: NSArray = NSArray()
      
      func myRankedFactorAnswersDownloaded(rankedFactors: NSArray) {
          myRankedFactors = rankedFactors
          
        //print (myRankedFactors)
        
        self.tableView!.backgroundColor = UIColor.clear
        
        tableView.reloadData()
      }
    
    
    // MARK: view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let getMyRankedFactors = MyRankedFactorAnswers()
        getMyRankedFactors.delegate = self
        getMyRankedFactors.downloadMyRankedFactors(userid: userId, order: factorTableOrder)
        
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myRankedFactors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FactorCell", for: indexPath) as? FactorAnswerTableViewCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue Factor Answer Cell.")
        }

        // Configure the cell...

        let thisFactorAnswer = myRankedFactors[indexPath[1]] as? MyRankedFactorAnswersModel
        
        let factorId    = thisFactorAnswer?.factorId
        let factorName  = thisFactorAnswer?.factorName as! String
        let factorImage = thisFactorAnswer?.factorImage as! String
        
        
        let tap = MyTapGesture(target: self, action: #selector(tappedMe))
        tap.q = String(thisFactorAnswer!.factorOrder!)
        tap.numberOfTapsRequired = 1
        
        cell.factorImage.addGestureRecognizer(tap)
        cell.factorImage.isUserInteractionEnabled = true
        
        
        let tap2 = MyTapGesture(target: self, action: #selector(tappedMe))
        tap2.q = String(thisFactorAnswer!.factorOrder!)
        tap2.numberOfTapsRequired = 1
        
        cell.factorName.addGestureRecognizer(tap2)
        cell.factorName.isUserInteractionEnabled = true
        
        //print (factorId)
       
        
        let thisSelectivity = thisFactorAnswer?.selectivity as! String
        
        cell.displayFactorAnswers(fqid: factorId!, factor: factorName, image: factorImage, selectivity: thisSelectivity)
        
        return cell
    }
    
    
    // when a question is chosen (tapped)
    @objc func tappedMe(sender : MyTapGesture) {
        
        //print (sender.q)
        factorOpt = Int(sender.q)!
        
        goBack = "SelectivityRankings"
    
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true, completion: nil)
        

    }
    
    class MyTapGesture: UITapGestureRecognizer {
         var q = String()
      
     }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
         
        let thisFactorAnswer = myRankedFactors[indexPath[1]] as? MyRankedFactorAnswersModel
               
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "FactorQuestions") as! FactorViewController
    
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true, completion: nil)
        
        factorOpt = thisFactorAnswer!.factorOrder!
        return true
    }
  */
    
    
        
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
