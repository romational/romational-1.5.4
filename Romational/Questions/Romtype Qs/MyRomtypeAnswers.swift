//
//  MyRomtypeAnswers.swift
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
    
    
    
    func downloadMyRomtypeAnswers(userid:String) {
        
        //let urlPath = "http://romadmin.com/userRomtypeAnswers.php?userId=\(userid)"
        let urlPath = "https://www.romdat.com/user/\(userid)/answers/romtypes"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("My Romtype Answers Data downloaded")
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
        
        var jsonElement = NSDictionary()
        let allMyRomtypeAnswers = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let myRomtypeAnswers = MyRomtypeAnswersModel()
            

            if let questionId = jsonElement["question_id"] as? String,
                let answer = jsonElement["answer_id"] as? String
                
            {
                //print (name)
                myRomtypeAnswers.questionId = questionId
                myRomtypeAnswers.answerId = answer
                
                //print (myRomtypeAnswers)
            }
            
            allMyRomtypeAnswers.add(myRomtypeAnswers)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.myRomtypeAnswersDownloaded(romtypeAnswers: allMyRomtypeAnswers)
            
        })
    }
    
}
