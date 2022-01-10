//
//  MyDemos.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyDemosProtocol: class {
    func myDemosDownloaded(demoInfo: NSArray)
}


class MyDemos: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: MyDemosProtocol!
    
    
    func downloadMyDemos(userid:String) {
        
        //let urlPath = "http://romadmin.com/userDemos.php?userId=\(userid)"
        print ("download demo user \(userid)")
        
        // production
        let urlPath = "https://www.romdat.com/user/\(userid)"
        // dev
        //let urlPath = "http://www.romdat-dev.com/user/\(userid)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download demographic data")
            }else {
                print("My Demos downloaded")
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var myProfileInfo = NSArray()
        
        do{
            myProfileInfo = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        //print (myProfileInfo)
        
        var jsonElement = NSDictionary()
        let allMyInfo = NSMutableArray()
        
        for i in 0..<myProfileInfo.count {
           
            jsonElement = myProfileInfo[i] as! NSDictionary
            
            print (jsonElement)
            
            let myProfile = MyDemosModel()
        
            if
                let nickName    = jsonElement["nickName"] as? String,
                let nameFirst    = jsonElement["nameFirst"] as? String,
                let nameLast     = jsonElement["nameLast"] as? String,
                let romMeCode    = jsonElement["romMeCode"] as? String,
                let userImage    = jsonElement["userImage"] as? String,
                let bday         = jsonElement["bday"] as? String,
                let location     = jsonElement["location"] as? String
                
            {
                
                //print (bday)
                myProfile.nickName      = nickName
                myProfile.nameFirst     = nameFirst
                myProfile.nameLast      = nameLast
                myProfile.romMeCode     = romMeCode
                myProfile.userImage     = userImage
                myProfile.bday          = bday
                myProfile.location      = location
                
                //print (myProfile)
            }
            
            allMyInfo.add(myProfile)
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.myDemosDownloaded(demoInfo: allMyInfo)
            
        })
    }
    
}
