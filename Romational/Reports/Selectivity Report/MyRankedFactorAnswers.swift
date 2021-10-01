//
//  MyRankedFactors.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyRankedFactorsProtocol: class {
    func myRankedFactorAnswersDownloaded(rankedFactors: NSArray)
}


class MyRankedFactorAnswers: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyRankedFactorsProtocol!
    
    
    
    func downloadMyRankedFactors(userid:String, order: String) {
        
        //let urlPath = "http://romadmin.com/rankedUserFactors.php?userId=\(userid)"
        
        let urlPath = "https://romdat.com/user/\(userid)/answers/rankedFactors/\(order)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("My Ranked Factor Answers downloaded")
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
        
        print (factorAnswers)
        
        //print (getFactorAnswers[factor])
        
        var jsonElement = NSDictionary()
        let allMyRankedFactors = NSMutableArray()
        
        for i in 0..<factorAnswers.count {
           
           
           // print (fid)
           jsonElement = factorAnswers[i] as! NSDictionary
            
            let myRankedFactors = MyRankedFactorAnswersModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let factorId    = jsonElement["factorId"] as? String,
                let factorOrder = jsonElement["factorOrder"] as? String,
                let factorName  = jsonElement["factorName"] as? String,
                let factorImage = jsonElement["factorImage"] as? String,
                let selectivity = jsonElement["selectivity"] as? String
            {
                //print (name)
                myRankedFactors.factorId      = Int(factorId)!
                myRankedFactors.factorOrder   = Int(factorOrder)!
                myRankedFactors.factorName    = factorName
                myRankedFactors.factorImage   = factorImage
                myRankedFactors.selectivity   = selectivity
                
                //print (myFactors)
            }
            
            allMyRankedFactors.add(myRankedFactors)
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.myRankedFactorAnswersDownloaded(rankedFactors: allMyRankedFactors)
            
        })
    }
    
}
