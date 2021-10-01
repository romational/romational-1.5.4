//
//  MyRomtypeData.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyRomtypeDataProtocol: class {
    func myRomtypeDataDownloaded(myRomtypeData: NSArray)
}


class MyRomtypeData: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyRomtypeDataProtocol!
    
    
    func downloadMyRomtypeData(userid: String) {
        
        //let urlPath = "http://romadmin.com/myRomtypeData.php?userId=\(userid)"
        let urlPath = "https://www.romdat.com/user/\(userid)/mydata/romtypes"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download Romtype List data")
            }else {
                print("Romtype List Data downloaded")
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
        let allMyRomtypesList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let myRomtypeList = MyRomtypeDataModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id              = jsonElement["id"] as? String,
                let order           = jsonElement["order"] as? String,
                let name            = jsonElement["name"] as? String,
                let image           = jsonElement["image"] as? String,
                let answer          = jsonElement["answer"] as? String
              
                
            {
                
                myRomtypeList.id          = Int(id)
                myRomtypeList.order       = Int(order)
                myRomtypeList.name        = name
                myRomtypeList.image       = image
                myRomtypeList.answer      = answer
                
                
                //print (myRomtypeList)
            }
            
            allMyRomtypesList.add(myRomtypeList)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.myRomtypeDataDownloaded(myRomtypeData: allMyRomtypesList)
            
            
        })
    }
    
}
