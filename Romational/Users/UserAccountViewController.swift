//
//  UserAccountViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 5/19/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class UserAccountViewController: UIViewController, UserLoginInfoProtocol, UITextFieldDelegate {
    
    var userLoginInfo :NSDictionary = NSDictionary()
    
    func UserLoginInfoDownloaded(userLoginInfo: NSDictionary) {
        self.userLoginInfo = userLoginInfo
        
        print (userLoginInfo)
        
        emailLabel.text      = ("Email : \( userLoginInfo["loginEmail"] as! String)")
        
        
    }
    

    // nav links
    
    @IBAction func gotoHome(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoConnect(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Connect") as! ConnectViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    @IBAction func gotoReports(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "Reports") as! ReportViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    var slideController : UserOptionsViewController!
    
    @IBAction func showSlideout(_ sender: Any) {
    
        slideController = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as! UserOptionsViewController
           
        let height = self.view.frame.height
        let width = self.view.frame.width
           
        slideController.view.frame = CGRect(x: 0, y: 40, width: 0, height: height)
        slideController.userOptionLogo.isHidden = true
        slideController.closeButton.isHidden = true
        slideController.userButtons.forEach { button in
                button.isHidden = true
            }
        slideController.userIcons.forEach { icon in
                icon.isHidden = true
            }
        slideController.view.isUserInteractionEnabled = true
            
            // animate the display
        UIView.animate(withDuration: 0.6, animations: { self.slideController.view.frame = CGRect(x:0, y:40, width: width, height: height) },
            completion: {(value: Bool) in
            
            self.slideController.closeButton.isHidden = false
            self.slideController.userOptionLogo.isHidden = false
            self.slideController.userButtons.forEach { button in
                    button.isHidden = false
                }
            self.slideController.userIcons.forEach { icon in
                    icon.isHidden = false
                }
           })
            
        self.view.insertSubview(self.slideController.view, at: 30)
            //addChildViewController(controller)
        self.slideController.didMove(toParentViewController: self)
            
        showMenu = true
       
    }
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var emailLabel: UILabel!

    
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBOutlet weak var updateEmail: UIButton!
    @IBOutlet weak var updatePass: UIButton!
    @IBOutlet weak var addToList: UIButton!
    
    var buttons = [UIButton]()
    
    @IBAction func updateAcctEmail(_ sender: Any) {
        
        updateEmail.setTitle("Updating...", for: .normal)
        
        if newEmail.text != "" && newEmail.text != userLoginInfo["loginEmail"] as! String {
            updateUserEmail(userid: userId, email: newEmail.text!)
            
            newEmail.isHidden      = true
           
        }
        
        updateEmail.setTitle("update complete", for: .normal)
        updateEmail.backgroundColor = orange
    }
    
    var valid = "yes"
    
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmError: UILabel!
    
    @IBAction func updateAcctPassword(_ sender: Any) {

        // turn off any existing errors
        passwordError.isHidden = true
        confirmError.isHidden = true
        valid = "yes"
        
        // check for password requirements
        if (newPassword.text!.isAlphanumeric == false) {
            valid = "no"
            passwordError.text = "Password must be alphanumeric"
            passwordError.isHidden = false
        }
        if (newPassword.text!.count < 6 ) {
            valid = "no"
            passwordError.text = "Password must be more than 6 characters"
            passwordError.isHidden = false
        }
        
        if (confirmPassword.text != newPassword.text) {
            valid = "no"
            confirmError.text = "Password confirmation does not match"
            confirmError.isHidden = false
        }
        
        // do the change if requirements pass
        if valid == "yes" {
            updatePass.setTitle("Updating...", for: .normal)
            
            if newPassword.text != "" && confirmPassword.text == newPassword.text {
                updateUserPassword(userid: userId, password: newPassword.text!)
               //passwordLabel.isHidden  = true
               //newPassLabel.isHidden   = true
               newPassword.isHidden    = true
               confirmPassword.isHidden   = true
            }
            
            updatePass.setTitle("update complete", for: .normal)
            updatePass.backgroundColor = orange
        }
        
    }
    
    
    @IBOutlet weak var addMe: UIButton!
    @IBAction func joinTheTeam(_ sender: Any) {
    
        joinTestingTeam(email: (userLoginInfo["loginEmail"] as? String)!)
        addMe.setTitle("You were added.", for: .normal)
        addMe.backgroundColor = green
    }
    
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        navBar.setBackgroundImage(imageName: "rom-rainbow.png", buffer: 80)
        navBar.setDropShadow(height: 4, opacity: 30, color: romDarkGray)
        
        let loginInfo = UserLoginInfo()
        loginInfo.delegate = self
        loginInfo.downloadUserLoginInfo()
        
        buttons.append(updateEmail)
        buttons.append(updatePass)
        //buttons.append(addToList)
        
        buttons.forEach { button in
            button.layer.cornerRadius = 20
            button.layer.masksToBounds = false
            button.layer.shadowColor = romDarkGray.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
        }
        
        newEmail.delegate = self
        newPassword.delegate = self
        confirmPassword.delegate = self
        
        newEmail.setLeftPaddingPoints(20)
        newPassword.setLeftPaddingPoints(20)
        confirmPassword.setLeftPaddingPoints(20)
        
        newEmail.layer.cornerRadius = 15
        newPassword.layer.cornerRadius = 15
        confirmPassword.layer.cornerRadius = 15
        
        newEmail.addBottomBorder(height: 1, color: romDarkGray)
        newPassword.addBottomBorder(height: 1, color: romDarkGray)
        confirmPassword.addBottomBorder(height: 1, color: romDarkGray)
        
        newPassword.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        
        passwordError.isHidden = true
        confirmError.isHidden = true
        
    }
    
    // MARK:  TextFields
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // resign keyboard on return
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // highlight colors
        textField.backgroundColor = romLightGray
       
        textField.layer.borderColor = romDarkGray.cgColor
        textField.layer.borderWidth = 1
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // default color
        textField.layer.borderWidth = 0
        
        textField.addBottomBorder(height: 1, color: romDarkGray)
        textField.backgroundColor = UIColor.clear
        
        //textField.layer.cornerRadius = 10
    }
    
    
    // view fucntions
    
    func joinTestingTeam(email: String) {
        post(parameters: [email], urlString: "http://romadmin.com/addToTestTeam.php")
    }

    
    
    func updateUserEmail(userid: String, email: String){
        
        //changeEmail(parameters: [userid, email], urlString: "http://romadmin.com/updateUserEmail.php")
        changeEmail(parameters: [userid, email], urlString: "https://romdat.com/user/\(userid)/update/email")
    }

    func updateUserPassword(userid: String, password: String){
        
       // changePassword(parameters: [userid, password], urlString: "http://romadmin.com/updateUserPassword.php")
       //changePassword(parameters: [userid, password], urlString: "https://romdat.com/user/\(userid)/update/password")
        
        postWithCompletion(parameters: [userId, password], urlString: "https://romdat.com/user/\(userid)/update/password") { success, result in
        
            print (result)
            if (result["success"] as! String == "yes")  {
                print ("changed")
                //self.tableView.reloadData()
                self.updatePass.setTitle( "password changed", for: .normal)
            }
            else {
                //self.newPassLabel.text = "problem updating"
                self.updatePass.setTitle( "problem updating", for: .normal)
            }
        }
        
    }
    
    func changeEmail(parameters : Array<String>, urlString : String)  {
        
        print (parameters)
        
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
                    
                    print (json)
                    
                    let success = json["success"]
                    if (success as! String == "no") {
                        
                        // email not found
                        if json["email"] as! String == "duplicate" {
                            DispatchQueue.main.async {
                                self.emailLabel.text = "duplicate email"
                                self.emailLabel.backgroundColor = yellow
                            }
                                print ("login failed email does not exist on file")
                        }
                        
                    }
                    
                    // email and password came back with result
                    if (success as! String == "yes") {
                       
                       
                        DispatchQueue.main.async {
                            self.emailLabel.text = "email changed"
                            self.emailLabel.backgroundColor = green
                        }
                    }
                        
                    
                    //print("Success: \(String(describing: success))")
                    //return (json)
                } else {
                    let jsonStr = String(data: data, encoding: .utf8)    // No error thrown, but not dictionary
                    print("Error could not parse JSON: \(String(describing: jsonStr))")
                    //return (jsonStr)
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = String(data: data, encoding: .utf8)
                print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                //return (jsonStr)
            }
        }
        
        task.resume()
    
    }

    
    func changePassword(parameters : Array<String>, urlString : String)  {
           
           print (parameters)
        
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
                       
                       print (json)
                       
                       let success = json["success"]
                       if (success as! String == "no") {
                           
                           // email not found
                           if json["password"] as! String == "problem" {
                               DispatchQueue.main.async {
                                   //self.newPassLabel.text = "problem updating"
                                    self.updatePass.setTitle( "problem updating", for: .normal)
                                    self.updatePass.layer.backgroundColor = yellow.cgColor
                               }
                                   print ("login failed email does not exist on file")
                           }
                           
                       }
                       
                       // email and password came back with result
                       if (success as! String == "yes") {
                          
                          
                           DispatchQueue.main.async {
                               //self.newPassLabel.text = "password changed"
                            self.updatePass.layer.backgroundColor = green.cgColor
                            self.updatePass.setTitle( "password changed", for: .normal)
                            
                            UserDefaults.standard.set(self.newPassword.text!, forKey: "password")
                           }
                       }
                           
                       
                       //print("Success: \(String(describing: success))")
                       //return (json)
                   } else {
                       let jsonStr = String(data: data, encoding: .utf8)    // No error thrown, but not dictionary
                       print("Error could not parse JSON: \(String(describing: jsonStr))")
                       //return (jsonStr)
                   }
               } catch let parseError {
                   print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                   let jsonStr = String(data: data, encoding: .utf8)
                   print("Error could not parse JSON: '\(String(describing: jsonStr))'")
                   //return (jsonStr)
               }
           }
           
           task.resume()
           
       }

}


// user function but used across many scripts
func updateUserLogs(userid: String, item: String){
    
    //post(parameters: [userid, item], urlString: "http://romadmin.com/updateUserLogs.php")
    post(parameters: [userid, item], urlString: "https://romdat.com/user/"+userid+"/logs/update")
}

