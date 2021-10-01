//
//  myRequests.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/15/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation



protocol MyRequestsProtocol: class {
    func myRequestsDownloaded(myRequests: NSArray)
}


class MyRequests: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyRequestsProtocol!
    
    let urlPath = "https://romdat.com/requests/\(userId)" //this will be changed to the path where service.php lives
    
    func downloadMyRequests() {
        
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download My Requests List data")
            }else {
                print("My Requests List downloaded")
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
        let allRequestsList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let myRequests = MyRequestsModel()
            
             print (jsonElement)
            
            // check for results to avoid empty set
            if  jsonElement["success"] as? String == "no" {
                
                
            }
            else {
                //the following insures none of the JsonElement values are nil through optional binding
                if
                    let id = jsonElement["userCompare_id"] as? String,
                    let requestUserId = jsonElement["userCompare_compare_id"] as? String,
                    let requestUserNickName = jsonElement["user_nickname"] as? String,
                    let requestUserNameFirst = jsonElement["user_name_first"] as? String,
                    let requestUserNameLast = jsonElement["user_name_last"] as? String,
                    let requestUserImage = jsonElement["user_image"] as? String,
                    let requestUserInfo = jsonElement["user_info"] as? String,
                    let introStatusMe = jsonElement["userCompare_intro_status-me"] as? String,
                    let introStatusThem = jsonElement["userCompare_intro_status-them"] as? String,
                    let levelOneStatusMe = jsonElement["userCompare_level-1_status-me"] as? String,
                    let levelOneStatusThem = jsonElement["userCompare_level-1_status-them"] as? String
                   // let factorStatus = jsonElement["userCompare_factor_status"] as? String
                    
                {
                    
                    myRequests.id           = Int(id)
                    myRequests.compareUserId  = Int(requestUserId)
                    myRequests.nickName     = requestUserNickName
                    myRequests.firstName    = requestUserNameFirst
                    myRequests.lastName     = requestUserNameLast
                    myRequests.image        = requestUserImage
                    myRequests.info         = requestUserInfo
                    
                    myRequests.introStatusMe   = introStatusMe
                    myRequests.level1StatusMe  = levelOneStatusMe
                    myRequests.level2StatusMe  = jsonElement["userCompare_level-2_status-me"] as? String
                    myRequests.level3StatusMe  = jsonElement["userCompare_level-3_status-me"] as? String
                    myRequests.level4StatusMe  = jsonElement["userCompare_level-4_status-me"] as? String
                    
                    myRequests.introStatusThem   = introStatusThem
                    myRequests.level1StatusThem  = levelOneStatusThem
                    myRequests.level2StatusThem  = jsonElement["userCompare_level-2_status-them"] as? String
                    myRequests.level3StatusThem  = jsonElement["userCompare_level-3_status-them"] as? String
                    myRequests.level4StatusThem  = jsonElement["userCompare_level-4_status-them"] as? String
                    
                    //print (myRequests)
                }
                
                allRequestsList.add(myRequests)
            }
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.myRequestsDownloaded(myRequests: allRequestsList)
            
        })
    }
    
}
