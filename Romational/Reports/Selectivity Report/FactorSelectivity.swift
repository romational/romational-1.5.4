//
//  FactorSelectivity.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol FactorSelectivityProtocol: class {
    func factorSelectivityDownloaded(selectivityIcons: NSArray)
}


class FactorSelectivity: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: FactorSelectivityProtocol!
    
    
    func downloadFactorIcons(userid: String) {
        
        //let urlPath = "http://romadmin.com/userFactorSelectivity.php?userId=\(userid)"
        let urlPath = "https://www.romdat.com/user/\(userid)/selectivity"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download selectivity ranks")
            }else {
                print("Selectivity Ranks downloaded")
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
        let allFactorRanks = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            //print (jsonElement)
            
            let factorRanks = FactorSelectivityModel()
            
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let rank = jsonElement["rank"] as? String,
                let total = jsonElement["total"] as? Int,
                let ids = jsonElement["ids"] as? Array<Any>
            {
                //print (name)
                factorRanks.rank = rank
                factorRanks.total = total
                factorRanks.ids = ids
                
                //print (factorRanks)
            }
            
            allFactorRanks.add(factorRanks)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.factorSelectivityDownloaded(selectivityIcons: allFactorRanks)
            
        })
    }
    
}
