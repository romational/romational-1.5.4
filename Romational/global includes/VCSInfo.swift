//
//  VCSInfo.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol VCSInfoProtocol: class {
    func VCSInfoDownloaded(vcsInfo: NSDictionary)
}


class VCSInfo: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: VCSInfoProtocol!
    
    //let urlPath = "http://romadmin.com/getVCSinfo.php"
    let urlPath = "http://www.romdat.com/vcsinfo"
    
    func downloadVCSInfo() {
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("View Controller Info downloaded")
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
        
        var storyboard = String()
        var jsonElement = NSDictionary()
        
        var VCSList = [String:VCSInfoModel]()
        
        let allVCSInfo = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let vcsInfo = VCSInfoModel()
            
            //print (jsonElement)
            
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let id              = jsonElement["vc_id"] as? String,
                let name            = jsonElement["vc_name"] as? String,
                let title           = jsonElement["vc_title"] as? String,
                let popup           = jsonElement["vc_popup"] as? String,
                let popupTitle           = jsonElement["vc_popup_title"] as? String,
                let popupButton           = jsonElement["vc_popup_button"] as? String,
                let vcClass         = jsonElement["vc_class"] as? String,
                let storyboardID    = jsonElement["vc_storyboard"] as? String,
                let image           = jsonElement["vc_image"] as? String,
                let info            = jsonElement["vc_info"] as? String
                
            {
                //print (name)
                vcsInfo.id           = Int(id)
                vcsInfo.name         = name
                vcsInfo.title        = title
                vcsInfo.popup        = popup
                vcsInfo.popupTitle   = popupTitle
                vcsInfo.popupButton  = popupButton
                vcsInfo.vcClass      = vcClass
                vcsInfo.storyboardID = storyboardID
                vcsInfo.image        = image
                vcsInfo.info         = info
                
                storyboard = storyboardID
                
                //print (vcsInfo)
            }
            
            VCSList[storyboard] = vcsInfo
            allVCSInfo.add(vcsInfo)
           
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate?.VCSInfoDownloaded(vcsInfo: (VCSList as? NSDictionary)!)
            
        })
    }
    
}
