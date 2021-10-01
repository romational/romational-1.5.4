//
//  MyFactors.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyFactorsProtocol: class {
    func myFactorAnswersDownloaded(factors: NSArray)
}


class MyFactorAnswers: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyFactorsProtocol!
    
    
    func downloadMyFactorAnswers(userid:String) {
        
        //let urlPath = "http://romadmin.com/userFactors.php?userId=\(userid)"
        let urlPath = "https://www.romdat.com/user/\(userid)/answers/factors"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("My Factor Answers downloaded")
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var factorAnswers = NSArray()
        
        do{
            factorAnswers = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        //print (factorAnswers)
        
        var jsonElement = NSDictionary()
        let allMyFactors = NSMutableArray()
        
        for i in 0..<factorAnswers.count {
           
           
           // print (fid)
           jsonElement = factorAnswers[i] as! NSDictionary
            
            let myFactors = MyFactorAnswersModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let factorId = jsonElement["factorId"] as? String,
                let answerId = jsonElement["answerId"] as? String,
                let selectivity = jsonElement["selectivity"] as? String
            {
                //print (name)
                myFactors.factorId = factorId
                myFactors.answerId = answerId
                myFactors.selectivity = selectivity
                
                //print (myFactors)
            }
            
            allMyFactors.add(myFactors)
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.myFactorAnswersDownloaded(factors: allMyFactors)
            
        })
    }
    
}
