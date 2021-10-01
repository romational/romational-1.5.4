//
//  RomtypeList.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 1/13/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation

protocol RomtypeWeightsProtocol: class {
    func weightsDownloaded(weights: NSArray)
}


class RomtypeWeights: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: RomtypeWeightsProtocol!
    
   
    
    func downloadWeights(userid: String) {
        
        let urlPath = "http://romadmin.com/userRomtypeWeights.php?userId=\(userid)" //this will be changed to the path where service.php lives
        // CONVERT TO PYTHON API URL ??
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download romtype weight data")
            }else {
                print("Romtype Weights Data downloaded")
                //print(data)
                self.parseJSON(data!)
                
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        //print (data)
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
       // print (jsonResult)
        //print (jsonResult["bCas"]!)
        
        var jsonElement = NSDictionary()
        let allWeightsList = NSMutableArray()

        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let weightsList = RomtypeWeightsModel()
            
             //print (jsonElement["type"])
            
        
            //the following insures none of the JsonElement values are nil through optional binding
            if
                let type      = jsonElement["type"] as? String,
                let percent   = jsonElement["percent"] as? Int
            {
      
                weightsList.type    = type
                weightsList.percent = percent
                
                print (weightsList)
            }
            
            allWeightsList.add(weightsList)
    
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.weightsDownloaded(weights: allWeightsList)
            
        })
    }
    
}
