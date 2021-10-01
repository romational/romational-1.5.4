//
//  MyProfileQAs.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol MyProfileQAProtocol: class {
    func myProfileQADownloaded(profileAnswers: NSArray)
}


class MyProfileQAs: NSObject, URLSessionDataDelegate {
    
    //properties
     weak var delegate: MyProfileQAProtocol!
    
    
    func downloadMyProfileQAs(userid:String) {
        
        //let urlPath = "http://romadmin.com/userProfiles.php?userId=\(userid)"
        let urlPath = "http://www.romdat.com/user/\(userid)/profiles"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download profile data")
            }else {
                print("My Profile Answers downloaded")
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
        let allMyPQAs = NSMutableArray()
        
        for i in 0..<myProfileInfo.count {
           
           
           // print (fid)
           jsonElement = myProfileInfo[i] as! NSDictionary
            
             //print (jsonElement)
            let pqas = MyProfileQAModel()
            
            if
                let pqid   = jsonElement["questionId"] as? String,
                let pqaid    = jsonElement["answerId"] as? String
                
            {
                
                //print (name)
                pqas.pqid = Int(pqid)!
                pqas.pqaid = Int(pqaid)!
                
                //print (myProfile)
            }
            
            allMyPQAs.add(pqas)
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
        
            self.delegate?.myProfileQADownloaded(profileAnswers: allMyPQAs)
            
        })
    }
    
}
