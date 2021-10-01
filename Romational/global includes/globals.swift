//
//  globals.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/24/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import Foundation
import UIKit

// user
var userId      = ""
var myApiKey    = "111aaa222bbb"

// user logs
var profileStarted          = ""
var prescreenStarted        = ""
var prescreenCompleted      = ""
var romtypeStarted          = ""
var romtypeCompleted        = ""
var flexibilityStarted      = ""
var flexibilityCompleted    = ""

// page info VCS variable
var VCS: NSDictionary = NSDictionary()
var Ranges: NSArray = NSArray()


// global vars
var showMenu = false

var factorOpt:Int = 0
var romtypeOpt:Int = 0
var goBack:String = ""

var selectivityIndex : Int = 0

var factorTableOrder = "normal"

// stanard colors
var black       =   UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
var white       =   UIColor(red:1, green:1, blue:1, alpha:1.0)
var offwhite    =   UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1.0)

// bkgd colors
var bkgdgray    =   UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0)
var palegray    =   UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.80)
var graphgray   =   UIColor(red: 0.8784, green: 0.8902, blue: 0.898, alpha: 1.0)

// selectivity colors
var yellow      =   UIColor(red:0.98, green:0.74, blue:0.24, alpha:1.0)
var green       =   UIColor(red:0.13, green:0.77, blue:0.54, alpha:1.0)
var teal        =   UIColor(red:0.15, green:0.72, blue:0.83, alpha:1.0)
var navy        =   UIColor(red:0.01, green:0.31, blue:0.43, alpha:1.0)
var purple      =   UIColor(red:0.65, green:0.31, blue:0.62, alpha:1.0)

// highlight colors
var orange      =   UIColor(red: 0.9608, green: 0.5765, blue: 0.1922, alpha: 1.0)
var coolblue    =   UIColor(red: 0, green: 0.8, blue: 1, alpha: 1.0)

// romtype colors
var pink        =   UIColor(red: 0.9804, green: 0.4471, blue: 0.5961, alpha: 1.0)
var red         =   UIColor(red: 0.949, green: 0, blue: 0, alpha: 1.0)

var lightgray   =   UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
var medgray     =   UIColor(red: 0.3333, green: 0.3333, blue: 0.3333, alpha: 1.0)
var darkgray    =   UIColor(red: 0.1373, green: 0.1216, blue: 0.1255, alpha: 1.0)


var romTeal      = UIColor(hue: 0.4722, saturation: 0.65, brightness: 0.85, alpha: 1.0) /* #4bdbc4 */
var romOrange    = UIColor(hue: 0.0861, saturation: 0.98, brightness: 1, alpha: 1.0) /* #ff8803 */
var romPink      = UIColor(hue: 0.9444, saturation: 0.89, brightness: 0.99, alpha: 1.0) /* #fe1a68 */

var romBlueCas  = UIColor(red: 0.1647, green: 0.7765, blue: 0.6863, alpha: 1.0) /* #2ac6af */
var romBlueDat  = UIColor(red: 0.1725, green: 0.6588, blue: 0.7686, alpha: 1.0) /* #2ca8c4 */
var romBlueCom  = UIColor(red: 0.1765, green: 0.5216, blue: 0.7569, alpha: 1.0) /* #2d85c1    */

var romRed       = UIColor(red: 0.9569, green: 0.2706, blue: 0.0314, alpha: 1.0) /* #f44508 */
var romPurple    = UIColor(red: 0.7882, green: 0.0235, blue: 0.9765, alpha: 1.0) /* #c906f9 */
var romLightGray = UIColor(hue: 0.8333, saturation: 0, brightness: 0.84, alpha: 1.0) /* #d8d6d8 */
var romDarkGray  = UIColor(hue: 0, saturation: 0.01, brightness: 0.44, alpha: 1.0) /* #727070 */
var romBlack     = UIColor(hue: 0, saturation: 0, brightness: 0.02, alpha: 1.0) /* #070707 */
var romBkgd      = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1.0) /* #f2f2f2 */




func post(parameters : Array<String>, urlString : String)  {
    
    //print (parameters)
    
    var request = URLRequest(url: URL(string: urlString)!)
    let session = URLSession.shared
    request.httpMethod = "POST"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
    request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
    

    let task = session.dataTask(with: request) { data, response, error in
        //print (data as Any)
        guard let data = data, error == nil else {
            
            print("error: \(String(describing: error))")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                let success = json["success"]
                print("Success: \(String(describing: success))")
             
            } else {
                let jsonStr = String(data: data, encoding: .utf8)    // No error thrown, but not dictionary
                print("Error could not parse JSON: \(String(describing: jsonStr))")
            }
        } catch let parseError {
            print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
            let jsonStr = String(data: data, encoding: .utf8)
            print("Error could not parse JSON: '\(String(describing: jsonStr))'")
        }
    }
    
    task.resume()
    
    
}


func postWithCompletion(parameters : Array<String>, urlString : String, completion: @escaping (String, NSDictionary) -> () )  {
    
    //print (parameters)
    
    var request = URLRequest(url: URL(string: urlString)!)
    let session = URLSession.shared
    request.httpMethod = "POST"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
    request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
    

    let task = session.dataTask(with: request) { data, response, error in
        
        DispatchQueue.main.async {
            
            /*
            //print (data as Any)
            guard let data = data, error == nil else {
                
                print("error: \(String(describing: error))")
                return
            }
             */
            
           // print (data!)
           // print("Response String: \(response)")
            
            /*.responseString { response in              print("Response String: \(response.result.value)")          }
            */
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments]) as? NSDictionary {
                    // process "json" as a dictionary
                    print ("dict")
                    print (json)
                    completion("results", json as! NSDictionary)
                } else if let json = try JSONSerialization.jsonObject(with: data!, options:[.allowFragments]) as? NSArray {
                    // process "json" as an array
                    print ("array")
                    print (json)
                    completion("results", json[0] as! NSDictionary)
                    
                } else {
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON string: \(jsonStr)")
                }
            }
            
            catch let parseError {
                
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = String(data: data!, encoding: .utf8)
                print("Error could not parse do JSON: '\(String(describing: jsonStr))'")
            
            }
            
            
            /*
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let success = json["success"]
                    print("Success: \(String(describing: success))")
                    
                    completion("Success", result["success"] as! String)
                 
                } else {
                    let jsonStr = String(data: data, encoding: .utf8)    // No error thrown, but not dictionary
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = String(data: data, encoding: .utf8)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
            }
             */
            
        }
        
    }
    
    task.resume()
    
    
}

func flexbilityColors(flexScoreLabel: UILabel, flexibility: Int) {
    
    print ("flexibility is \(flexibility)")
    
    //print ("ranges here")
    for i in 0..<Ranges.count {
        
        let thisRange = Ranges[i] as? NSDictionary
        
        flexScoreLabel.layer.cornerRadius = 20
        flexScoreLabel.layer.masksToBounds = true
        
        //let rangeName = thisRange!["name"] as? String
        let lowRange  = Int((thisRange!["low"] as? String)!)!
        let highRange = Int((thisRange!["high"] as? String)!)!
    
        if (flexibility > lowRange) && (flexibility <= highRange) {
          // print ("hi im \(lowRange) to \(highRange) i is \(i)")
            if i == 0 {
                flexScoreLabel.layer.borderWidth = 2
                flexScoreLabel.layer.borderColor = romTeal.cgColor
               //selectivityColorBox.backgroundColor = yellow
            }
            if i == 1 {
                flexScoreLabel.layer.borderWidth = 2
                flexScoreLabel.layer.borderColor = green.cgColor
                //selectivityColorBox.backgroundColor = green
            }
            if i == 2 {
                flexScoreLabel.layer.borderWidth = 2
                flexScoreLabel.layer.borderColor = yellow.cgColor
                //selectivityColorBox.backgroundColor = teal
            }
            if i == 3 {
                flexScoreLabel.layer.borderWidth = 2
                flexScoreLabel.layer.borderColor = romOrange.cgColor
                //selectivityColorBox.backgroundColor = navy
            }
            if i == 4 {
                flexScoreLabel.layer.borderWidth = 2
                flexScoreLabel.layer.borderColor = romPink.cgColor
               // selectivityColorBox.backgroundColor = purple
            }
            
         
            
        }
    }
        
}
