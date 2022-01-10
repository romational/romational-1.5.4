//
//  FactorList.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol FactorListProtocol: class {
    func factorsDownloaded(factors: NSArray)
}


class FactorList: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: FactorListProtocol!
    // prod
    let urlPath = "https://www.romdat.com/factors" //this will be changed to the path where service.php lives
    // dev
    //let urlPath = "http://www.romdat-dev.com/factors" //this will be changed to the path where service.php lives

    func downloadItems() {
        
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download Factor List data")
            }else {
                print("Factor List Datas downloaded")
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
        let allFactorsList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let factorList = FactorListModel()
            
             //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id = jsonElement["factor_id"] as? String,
                let name = jsonElement["factor_name"] as? String,
                let order = jsonElement["factor_order"] as? String,
                let image = jsonElement["factor_image"] as? String,
                let info = jsonElement["factor_info"] as? String,
                let beforeImage = jsonElement["factor_before_image"] as? String,
                let beforeTitle = jsonElement["factor_before_title"] as? String,
                let beforeText = jsonElement["factor_before_text"] as? String,
                let beforeButton = jsonElement["factor_before_button"] as? String
                
            {
                
                factorList.id           = Int(id)
                factorList.name         = name
                factorList.order        = Int(order)
                factorList.image        = image
                factorList.info         = info
                factorList.beforeImage  = beforeImage
                factorList.beforeTitle  = beforeTitle
                factorList.beforeText   = beforeText
                factorList.beforeButton = beforeButton
                
                //print (factorList)
            }
            
            allFactorsList.add(factorList)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.factorsDownloaded(factors: allFactorsList)
            
        })
    }
    
}
