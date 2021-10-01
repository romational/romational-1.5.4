//
//  MyExclusivity.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol ExclusivityProtocol: class {
    func exclusivityDownloaded(exclusivity: NSDictionary)
}


class MyExclusivity: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: ExclusivityProtocol!
    
    
    func downloadMyExclusivity(userid:String) {
        
        let urlPath = "http://romadmin.com/myExclusivity.php?userId=\(userid)" //this will be changed to the path where service.php lives
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Exclusivity downloaded")
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
            
            self.delegate?.exclusivityDownloaded(exclusivity: jsonResult)
            
        })
    }
    
}
