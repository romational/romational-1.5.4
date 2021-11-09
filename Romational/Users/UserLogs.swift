//
//  UserLogos.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol UserLogsProtocol: class {
    func UserLogsDownloaded(userLogs: NSArray)
}


class UserLogs: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: UserLogsProtocol!
    
    
    func downloadUserLogs() {
        
        let urlPath = "https://www.romdat.com/user/\(userId)/logs/"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download user logs")
            }else {
                print("user logs downloaded")
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
        //print jsonResult[0]["prescreenStarted"]
        
        var jsonElement = NSDictionary()
        
      
        for i in 0 ..< jsonResult.count {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            //print (jsonElement)
            
            //let userLog = UserLogsModel()
            
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
               
                let logId       = jsonElement["userLog_id"] as? Int,
                let logUserId   = jsonElement["userLog_user_id"] as? Int,
                let logItem     = jsonElement["userLog_item"] as? String,
                let logDate     = jsonElement["userLog_datetime"] as? String
            
            {
                if jsonElement["userLog_item"] as! String == "profile-started" {
                    profileStarted     = "yes"
                }
                
                if jsonElement["userLog_item"] as! String == "prescreen-started" {
                    prescreenStarted     = "yes"
                }
                if jsonElement["userLog_item"] as! String == "prescreen-completed"{
                    prescreenCompleted  = "yes"
                }
                if jsonElement["userLog_item"] as! String == "romtype-started" {
                    romtypeStarted = "yes"
                }
                if jsonElement["userLog_item"] as! String == "romtype-completed" {
                    romtypeCompleted = "yes"
                }
                if jsonElement["userLog_item"] as! String == "flexibility-started" {
                    flexibilityStarted = "yes"
                }
                if jsonElement["userLog_item"] as! String == "flexibility-completed" {
                    flexibilityCompleted = "yes"
                }
                
   
            }
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.UserLogsDownloaded(userLogs: jsonResult)
            
        })
    }
    
}
