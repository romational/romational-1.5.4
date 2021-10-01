//
//  MyFactorData.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyFactorDataProtocol: class {
    func myFactorDataDownloaded(myFactorData: NSArray)
}


class MyFactorData: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyFactorDataProtocol!
    
    
    func downloadMyFactorData(userid: String) {
        
        //let urlPath = "http://romadmin.com/myFactorData.php?userId=\(userid)"
        let urlPath = "https://www.romdat.com/user/\(userid)/mydata/factors"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download Factor List data")
            }else {
                print("Factor List Data downloaded")
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
        let allMyFactorsList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let myFactorList = MyFactorDataModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id              = jsonElement["id"] as? String,
                let order           = jsonElement["order"] as? String,
                let name            = jsonElement["name"] as? String,
                let image           = jsonElement["image"] as? String,
                let answer          = jsonElement["answer"] as? String,
                let selectivity     = jsonElement["selectivity"] as? String
                
            {
                
                myFactorList.id          = Int(id)
                myFactorList.order       = Int(order)
                myFactorList.name        = name
                myFactorList.image       = image
                myFactorList.answer      = answer
                myFactorList.selectivity = Double(selectivity)
                
                
                //print (factorList)
            }
            
            allMyFactorsList.add(myFactorList)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.myFactorDataDownloaded(myFactorData: allMyFactorsList)
            
        })
    }
    
}
