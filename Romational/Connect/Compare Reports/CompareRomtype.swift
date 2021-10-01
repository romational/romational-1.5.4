//
//  CompareRomtype.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/12/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation


protocol CompareRomtypeProtocol: class {
    func compareRomtypeDownloaded(compareRomtypeInfo: NSArray)
}


class CompareRomtype: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: CompareRomtypeProtocol!
    
    
    func downloadCompareRomtype(userid: String) {
        
       // let urlPath = "http://romadmin.com/myRomtype.php?userId=\(userid)"
        let urlPath = "https://www.romdat.com/user/\(userid)/romtype"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download romtype data")
            }else {
                print("Compare Romtype Data downloaded")
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
        
        let myRomtype = NSArray()
        
        /*
        var jsonElement = NSDictionary()
        let allRomtypesList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let romtypeList = MyRomtypeModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id = jsonElement["romtype_id"] as? String,
                let name = jsonElement["romtype_name"] as? String,
                let image = jsonElement["romtype_image"] as? String,
                let info = jsonElement["romtype_info"] as? String
                
            {
                //print (name)
                romtypeList.id = Int(id)
                romtypeList.name = name
                romtypeList.image = image
                romtypeList.info = info
                
                
                print (romtypeList)
            }
            
            allRomtypesList.add(romtypeList)
           
        
        }
        */
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.compareRomtypeDownloaded(compareRomtypeInfo: jsonResult)
            
        })
    
    }
    
}

