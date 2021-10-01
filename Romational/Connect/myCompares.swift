//
//  myCompares.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/8/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation


protocol MyComparesProtocol: class {
    func myComparesDownloaded(myCompares: NSArray)
}


class MyCompares: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyComparesProtocol!
    
    let urlPath = "https://romdat.com/compares/\(userId)" //this will be changed to the path where service.php lives
    
    func downloadMyCompares() {
        
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download My Compares List data")
            }else {
                print("My Compares List downloaded")
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
        let allComparesList = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let myCompares = MyComparesModel()
            
            print (jsonElement)
            
            // check for results avoid empty set print
            if  jsonElement["success"] as? String == "no" {
            
                
            }
            else {
                //the following insures none of the JsonElement values are nil through optional binding
                if
                    let id = jsonElement["userCompare_id"] as? String,
                    let compareUserId = jsonElement["userCompare_compare_id"] as? String,
                    let compareUserNickName = jsonElement["user_nickname"] as? String,
                    let compareUserNameFirst = jsonElement["user_name_first"] as? String,
                    let compareUserNameLast = jsonElement["user_name_last"] as? String,
                    let compareUserImage = jsonElement["user_image"] as? String,
                    let compareUserInfo = jsonElement["user_info"] as? String,
                    let introStatusMe = jsonElement["userCompare_intro_status-me"] as? String,
                    let introStatusThem = jsonElement["userCompare_intro_status-them"] as? String,
                    let levelOneStatusMe = jsonElement["userCompare_level-1_status-me"] as? String,
                
                    let levelOneStatusThem = jsonElement["userCompare_level-1_status-them"] as? String
                    
                   // let factorStatus = jsonElement["userCompare_factor_status"] as? String
                    
                {
                    
                    myCompares.id            = Int(id)
                    myCompares.userId        = Int(compareUserId)
                    myCompares.nickName      = compareUserNickName
                    myCompares.firstName     = compareUserNameFirst
                    myCompares.lastName      = compareUserNameLast
                    myCompares.image         = compareUserImage
                    myCompares.info          = compareUserInfo
                    
                    myCompares.introStatusMe = introStatusMe
                    myCompares.level1StatusMe  = levelOneStatusMe
                    myCompares.level2StatusMe  = jsonElement["userCompare_level-2_status-me"] as? String
                    myCompares.level3StatusMe  = jsonElement["userCompare_level-3_status-me"] as? String
                    myCompares.level4StatusMe  = jsonElement["userCompare_level-4_status-me"] as? String
                    
                    myCompares.introStatusThem = introStatusThem
                    myCompares.level1StatusThem  = levelOneStatusThem
                    myCompares.level2StatusThem  = jsonElement["userCompare_level-2_status-them"] as? String
                    myCompares.level3StatusThem  = jsonElement["userCompare_level-3_status-them"] as? String
                    myCompares.level4StatusThem  = jsonElement["userCompare_level-4_status-them"] as? String
                    
                    print (myCompares)
                }
                
                allComparesList.add(myCompares)
            }
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.myComparesDownloaded(myCompares: allComparesList)
            
        })
    }
    
}
