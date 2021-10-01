//
//  ProfileQuestions.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol ProfileQuestionProtocol: class {
    func questionsDownloaded(questions: NSArray)
}


class ProfileQuestions: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: ProfileQuestionProtocol!
    
    //let urlPath = "http://romadmin.com/profileQuestions.php" /
    let urlPath = "https://romdat.com/profile/questions/"
    
    func downloadProfileQuestions() {
        
        let url: URL = URL(string: urlPath)!
       
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Profile Questions downloaded")
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
        
        //print (jsonResult)
        
        var jsonElement = NSArray()
        let getAllQuestions = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSArray
            
            let profQs = ProfileQuestionModel()
            
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id       = jsonElement[0] as? String,
                let order    = jsonElement[1] as? String,
                let name     = jsonElement[2] as? String,
                let question = jsonElement[3] as? String,
                let answers  = jsonElement[4] as? NSArray
            {
                profQs.id       = Int(id)
                profQs.order    = Int(order)
                profQs.name     = name
                profQs.question = question
                profQs.answers  = answers as? Array
                
                
               // print (profQs)
            }
            
            getAllQuestions.add(profQs)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.questionsDownloaded(questions: getAllQuestions)
            
        })
    }
    
}
