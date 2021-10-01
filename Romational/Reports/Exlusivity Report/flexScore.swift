//
//  flexScore.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 9/2/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation


protocol FlexScoreProtocol: class {
    func flexScoreDownloaded(flexScore: NSDictionary)
}


class MyFlexScore: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: FlexScoreProtocol!
    
    
    func downloadMyFlexScore(userid:String) {
        
        let urlPath = "http://romdat.com/user/\(userid)/flexScore" //this will be changed to the path where service.php lives
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("FlexScore downloaded")
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
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.flexScoreDownloaded(flexScore: jsonResult)
            
        })
    }
    
}
