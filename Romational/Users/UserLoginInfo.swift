//
//  UserLoginInfo.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol UserLoginInfoProtocol: class {
    func UserLoginInfoDownloaded(userLoginInfo: NSDictionary)
}


class UserLoginInfo: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: UserLoginInfoProtocol!
    
    
    func downloadUserLoginInfo() {
        
        //let urlPath = "http://romadmin.com/getUserLoginInfo.php?userId=\(userId)"
        let urlPath = "https://romdat.com/user/\(userId)/logininfo"

        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download user login info")
            }else {
                print("user login info downloaded")
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
        
        //print (jsonResult)
        //print jsonResult[0]["prescreenStarted"]
        
        /*
         
        var jsonElement = NSDictionary()
        
     
        jsonElement = jsonResult[0] as! NSDictionary
        
        let userLoginInfo = UserLoginInfoModel()
        
        //print (jsonElement)
        
        //the following insures none of the JsonElement values are nil through optional binding
        if
            let loginEmail       = jsonElement["email"] as? String,
            let loginPassword    = jsonElement["password"] as? String
            
        {
            //print (name)
            userLoginInfo.loginEmail        = loginEmail
            userLoginInfo.loginPassword     = loginPassword
            

        }
    
        */
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.UserLoginInfoDownloaded(userLoginInfo: jsonResult)
            
        })
    }
    
}
