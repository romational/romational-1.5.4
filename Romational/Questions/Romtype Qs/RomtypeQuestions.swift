//
//  RomtypeQuestions.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol RomtypeQuestionProtocol: class {
    func questionsDownloaded(questions: NSArray)
}


class RomtypeQuestions: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: RomtypeQuestionProtocol!
    
    //let urlPath = "http://romadmin.com/romtypeQuestions.php"
    let urlPath = "https://romdat.com/romtypes/questions"
    
    func downloadQuestions() {
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Romtype Questions downloaded")
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
            
            let romQs = RomtypeQuestionModel()
            
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id       = jsonElement[0] as? String,
                let order    = jsonElement[1] as? String,
                let name     = jsonElement[2] as? String,
                let image    = jsonElement[3] as? String,
                let question = jsonElement[4] as? String,
                let info     = jsonElement[5] as? String,
                let answers  = jsonElement[6] as? NSArray
            {
                romQs.id        = Int(id)
                romQs.order     = Int(order)
                romQs.name      = name
                romQs.image     = image
                romQs.question  = question
                romQs.info      = info
                romQs.answers   = answers as? Array
                
            }
            
            //print (romQs)
            getAllQuestions.add(romQs)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.questionsDownloaded(questions: getAllQuestions)
            
        })
    }
    
}
