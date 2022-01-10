//
//  RomtypeList.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol RomtypeInfoProtocol: class {
    func infoDownloaded(info: NSDictionary)
}


class RomtypeInfo: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: RomtypeInfoProtocol!
    
    func downloadInfo(romtype:String) {
        
        let urlPath = "https://romdat.com/romtype/\(romtype)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Romtype Info downloaded")
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSDictionary()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
        } catch let error as NSError {
            print(error)
            
        }
        /*
        var jsonElement = NSDictionary()
        let allRomtypesInfo = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let romtypeInfo = RomtypeListModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["romtype_name"] as? String,
                let image = jsonElement["romtype_image"] as? String,
                let info = jsonElement["romtype_info"] as? String,
                let id = jsonElement["romtype_id"] as? String
            {
                //print (name)
                romtypeInfo.name = name
                romtypeInfo.image = image
                romtypeInfo.info = info
                romtypeInfo.id = Int(id)
                
                //print (romtypeInfo)
            }
            
            allRomtypesInfo.add(romtypeInfo)
           //print (allRomtypesInfo)
        }
        */
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.infoDownloaded(info: jsonResult)
            
        })
    }
    
}
