//
//  RomtypeList.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol RTQListProtocol: class {
    func RTQListDownloaded(rtqlist: NSArray)
}


class RTQList: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: RTQListProtocol!
    
    
    
    func downloadRTQList() {
        
        //let urlPath = "http://romadmin.com/rtqlist.php"
        let urlPath = "https://www.romdat.com/rtqlist"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            } else {
                print("Romtype Question List downloaded")
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
        let allRTQList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSArray
            
            let rtqList = RTQListModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id = jsonElement[0] as? String,
                let order = jsonElement[1] as? String,
                let name = jsonElement[2] as? String,
                let image = jsonElement[3] as? String,
                let info = jsonElement[4] as? String
                
            {
                //print (name)
                rtqList.id = Int(id)
                rtqList.order = Int(order)
                rtqList.name = name
                rtqList.image = image
                rtqList.info = info
                
                
                //print (rtqList)
            }
            
            allRTQList.add(rtqList)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.RTQListDownloaded(rtqlist: allRTQList)
            
        })
    }
    
}
