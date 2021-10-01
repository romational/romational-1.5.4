//
//  RomtypeList.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol RomtypeListProtocol: class {
    func romtypesDownloaded(romtypes: NSArray)
}


class RomtypeList: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: RomtypeListProtocol!
    
    let urlPath = "https://romdat.com/romtypes" //this will be changed to the path where service.php lives
    
    
    func downloadRomtypes() {
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Romtype Data downloaded")
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
        let allRomtypesList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let romtypeList = RomtypeListModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id          = jsonElement["romtype_id"] as? String,
                let name        = jsonElement["romtype_name"] as? String,
                let code        = jsonElement["romtype_code"] as? String,
                let image       = jsonElement["romtype_image"] as? String,
                let definition  = jsonElement["romtype_define"] as? String,
                let info        = jsonElement["romtype_info"] as? String
                
            {
                //print (name)
                romtypeList.id          = Int(id)
                romtypeList.name        = name
                romtypeList.code        = code
                romtypeList.image       = image
                romtypeList.definition  = definition
                romtypeList.info        = info
                
                
                //print (romtypeList)
            }
            
            allRomtypesList.add(romtypeList)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.romtypesDownloaded(romtypes: allRomtypesList)
            
        })
    }
    
}
