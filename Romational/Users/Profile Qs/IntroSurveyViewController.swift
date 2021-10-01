//
//  PrescreenViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 11/9/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit
import CoreData


class IntroSurveyViewController: UIViewController, ProfileQuestionProtocol, MyProfileQAProtocol {
    
    
    var userInfo: [NSManagedObject] = []
      
    @IBAction func gotoUserMenu(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "UserOptions") as! UserOptionsViewController
        self.present(destination, animated: true)
    }
    
    @IBOutlet var profileView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var Q1: UILabel!
    
    
    // view did load
    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.addSubview(scrollView)
        
        //scrollView.delegate = self
        
        scrollView.isScrollEnabled = true
        
        // Do any additional setup after loading the view
        //scrollView.contentSize = CGSizeMake(400, 2300)
        
        // bring in profile questions
        let profileQs = ProfileQuestions()
        profileQs.delegate = self
        profileQs.downloadProfileQuestions()
        
      
        
    }

    
    // download profile info
    var ProfileQuestionsList : NSArray = NSArray()
    
    func questionsDownloaded(questions: NSArray) {
        
        ProfileQuestionsList = questions
        
        // bring in user profile
        let myProfileQA = MyProfileQAs()
        myProfileQA.delegate = self
        myProfileQA.downloadMyProfileQAs(userid: userId)
        
    }
    
    
    // download profile info
    var myProfileQAs : NSArray = NSArray()
    
    func myProfileQADownloaded(profileAnswers: NSArray) {
        
        myProfileQAs = profileAnswers
        print (myProfileQAs)
     
        printProfileQuestions()
        
    }
    

    func printProfileQuestions() {
        
        //let qStartX = print(Q1.frame.origin.x)
        var labelMarker = Q1.frame.origin.y + 30
        
        //print ("\(qStartX) \(qStartY)")
        
        for i in 0 ..< ProfileQuestionsList.count {
            
            let pquestion = ProfileQuestionsList[i] as! ProfileQuestionModel
            
            labelMarker += 20
            
            var label = UILabel(frame: CGRect(x: CGFloat(0.04 * view.bounds.width), y: CGFloat(labelMarker), width: CGFloat(0.92 * view.bounds.width), height: 20))
            label.text = pquestion.question!
            label.font = UIFont.boldSystemFont(ofSize: 18.0)
            
            profileView.addSubview(label)
            
            labelMarker += 30
            
            let PQ = pquestion.id!
            
            let PQAnswers = pquestion.answers!
   
            for l in 0..<PQAnswers.count {
               
                let answer = PQAnswers[l] as! [String:Any]
                
                print (answer)
                
                let PQA = answer["profileAnswer_id"]! as! String

                //print (PQA)
                
                // create label
                var label = UILabel(frame: CGRect(x: CGFloat(0.05 * view.bounds.width), y: CGFloat(labelMarker), width: CGFloat(0.90 * view.bounds.width), height: 35))
                
                label.text = answer["profileAnswer_text"]! as! String
                label.font = UIFont.systemFont(ofSize: 14.0)
                
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                label.numberOfLines = 0
                
                labelMarker += 35
                
                // tap gesture
                let tap = MyTapGesture(target: self, action: #selector(IntroSurveyViewController.tappedMe))
                
                label.addGestureRecognizer(tap)
                label.isUserInteractionEnabled = true
                
                tap.q = String(i + 1)
                tap.qa = answer["profileAnswer_id"] as! String
                
                
                // answer bkgd
                var chosen = "no"
                
                for q in 0..<myProfileQAs.count {
                     
                    let profQA = myProfileQAs[q] as! MyProfileQAModel
                    
                    if (profQA.pqid! == PQ) {
                        print ("live question")
                        print (profQA.pqaid!)
                        
                        if (profQA.pqaid!) == Int(PQA) {
                            chosen = "yes"
                        }
                    }
                    
                    //print (PQ)
                    print (chosen)

                }
                
                //label.backgroundColor = UIColor.clear
                                   
                if (chosen == "yes") {
                    label.backgroundColor = UIColor.white
                }
                else {
                    label.backgroundColor = UIColor.clear
                }
                
                profileView.addSubview(label)
                
            }
            
            labelMarker += 20
            
            profileView.setNeedsLayout()
            profileView.setNeedsUpdateConstraints()
            profileView.updateConstraintsIfNeeded()
        }
  
        
    }
    
    func saveUserProfile(pq: String, pqa: String) {
        
        updateUserProfileQuestions(userid: userId, pq: pq, pqa: pqa )
   
        // bring in user profile
        let myProfileQA = MyProfileQAs()
        myProfileQA.delegate = self
        myProfileQA.downloadMyProfileQAs(userid: userId)
        
        printProfileQuestions()
        
    }
    
    
    
    // when a question is chosen (tapped)
    @objc func tappedMe(sender : MyTapGesture) {
        
        //print (sender.q)
        //print (sender.qa)

        saveUserProfile(pq: sender.q, pqa: sender.qa)
        
        
    
    }
    
    
    class MyTapGesture: UITapGestureRecognizer {
        var q = String()
        var qa = String()
   
    }
    
}

