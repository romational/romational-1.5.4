//
//  MyRomtypes.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyRomtypeAnswersProtocol: class {
    func myRomtypeAnswersDownloaded(romtypeAnswers: NSArray)
}


class MyRomtypeAnswers: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyRomtypeAnswersProtocol!
    
    let urlPath = "http://romational.com/app/userRomtypeAnswers.php" //this will be changed to the path where service.php lives
    
    func downloadMyRomtypes() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("My Factors Data downloaded")
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let allMyRomtypes = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let myAnswers = MyRomtypesModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let questionId = jsonElement["userRomtype_question_id"] as? String,
                let answer = jsonElement["userRomtype_answer_id"] as? String,
                let selectivity = jsonElement["userFactor_selectivity"] as? String
            {
                //print (name)
                myAnswers.questionId = questionId
                myAnswers.answer = answer
               
                print (myAnswers)
            }
            
            allMyRomtypes.add(myAnswers)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.myRomtypeAnswersDownloaded(romtypeAnswers: allMyRomtypes)
            
        })
    }
    
}
