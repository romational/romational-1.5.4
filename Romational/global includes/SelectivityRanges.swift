//
//  selectivityRanges.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 9/8/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation


protocol SelectivityRangesProtocol: class {
    func SelectivityRangesDownloaded(ranges: NSArray)
}


class SelectivityRanges: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: SelectivityRangesProtocol!
    
    
    func downloadSelectivityRanges() {
        
        //let urlPath = "http://romadmin.com/getSelectivityRanges.php"
        // prod path
        let urlPath = "https://www.romdat.com/ranges"
        // dev path (12.7.21 add default table column for slider buttons)
        //let urlPath = "http://www.romdat-dev.com/ranges"
    
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download user logs")
            }else {
                print("selectivity ranges downloaded")
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
        
        print (jsonResult)
        //print jsonResult[0]["prescreenStarted"]
        
        var jsonElement = NSDictionary()
        
      
        jsonElement = jsonResult[0] as! NSDictionary
        
        let thisRange = RangeModel()
        
        //print (jsonElement)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if
            let id           = jsonElement["selectivity_id"] as? Int,
            let name         = jsonElement["selectivity_name"] as? String,
            let low          = jsonElement["selectivity_low"] as? Int,
            let high         = jsonElement["selectivity_high"] as? Int,
            let ranking      = jsonElement["selectivity_default"] as? Int,
            let info         = jsonElement["selectivity_info"] as? String
            
        {
            //print (name)
            thisRange.id        = id
            thisRange.name      = name
            thisRange.low       = low
            thisRange.high      = high
            thisRange.ranking   = ranking
            thisRange.info      = info
    
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.SelectivityRangesDownloaded(ranges: jsonResult)
            
        })
    }
    
}
