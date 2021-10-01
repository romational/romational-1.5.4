//
//  LogInViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 3/12/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, VCSInfoProtocol, SelectivityRangesProtocol, UITextFieldDelegate {
    

    func VCSInfoDownloaded(vcsInfo: NSDictionary) {
        VCS = vcsInfo
        
        //print (VCS["MainMenu"])
        
        let pageInfo = VCS["LoginWelcome"] as? VCSInfoModel
        
        if (pageInfo?.info != nil) {
             
            //loginIntroText.text = pageInfo!.info
            //loginIntroText.textAlignment = .center
            //loginIntroText.textColor = romDarkGray
        }
        
    }
    
    func SelectivityRangesDownloaded(ranges: NSArray) {
        Ranges = ranges
        
        //print (Ranges)
    }
    
    @IBOutlet weak var loginIntroText: UILabel!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var emailFieldBox: UIView!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordFieldBox: UIView!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    @IBOutlet weak var saveLoginInfo: UISwitch!
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signInBkgd: UIView!
    @IBOutlet weak var signInBox: UIView!
    
    @IBAction func signinButton(_ sender: Any) {
        
        signInBtn.layer.backgroundColor = romLightGray.cgColor
        let checkemail = emailField.text!
        let checkpass  = passwordField.text!
        
        let checkResults = checkUserPass(email: checkemail, password: checkpass)
        
        //print (checkResults)
        
        if saveLoginInfo.isOn == true {
            UserDefaults.standard.set(emailField.text, forKey: "email")
            UserDefaults.standard.set(passwordField.text, forKey: "password")
            UserDefaults.standard.set(true, forKey: "save")
        }
        else {
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "password")
            UserDefaults.standard.set(false, forKey: "save")
        }
        
    }
    
    
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // view info import
        let vcsInfo = VCSInfo()
        vcsInfo.delegate = self
        vcsInfo.downloadVCSInfo()
        
        let selRanges = SelectivityRanges()
        selRanges.delegate = self
        selRanges.downloadSelectivityRanges()
        
        
        // logo styles
        logoImage.image  = UIImage(named:"romational-icon-v4.png")
        
        logoImage.addBkgdShadowToImage(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 60, shadowSize: 4)
        
        logoImage.layer.cornerRadius = 25
        
        
        // assign delegate for TextField delegate functions
        emailField.delegate = self
        passwordField.delegate = self
        
        // use password protection
        passwordField.isSecureTextEntry = true
        
        
        emailField.addBottomBorder(height: 1, color: romDarkGray)
        passwordField.addBottomBorder(height: 1, color: romDarkGray)
        
        emailField.setLeftPaddingPoints(20)
        passwordField.setLeftPaddingPoints(20)
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: romDarkGray])
        
        emailField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: romDarkGray])
        
        emailField.textColor = romDarkGray
        passwordField.textColor = romDarkGray
        
        
        emailField.layer.cornerRadius = 20
        emailField.layer.masksToBounds = true
        //emailField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        passwordField.layer.cornerRadius = 20
        passwordField.layer.masksToBounds = true
        //passwordField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        
        // save default settings
        emailField.text = UserDefaults.standard.object(forKey:"email") as? String
        passwordField.text = UserDefaults.standard.object(forKey:"password") as? String
        if (UserDefaults.standard.object(forKey:"email") as? String == "") {
            saveLoginInfo.isOn = true
        }
        else {
            saveLoginInfo.isOn = UserDefaults.standard.bool(forKey:"save")
        }
        
        
        // sign in button shadow
        //signInBtn.addInnerShadowToButton(color: white, offsetX: -6, offsetY: -6, shadowSize: 4)
        //signInBtn.addInnerShadowToButton(color: romDarkGray, offsetX: 3, offsetY: 3, shadowSize: 9)
        
        signInBtn.layer.cornerRadius = 25
        
        
        // sign in button bkgds
        signInBkgd.layer.borderColor = white.cgColor
        signInBkgd.layer.borderWidth = 4
        signInBkgd.layer.cornerRadius = 25
        
        //signInBkgd.addBkgdShadowToView(color: white, offsetX: -14, offsetY: -3, opacity: 90, shadowSize: 2)
        
        signInBkgd.layer.masksToBounds = false
        signInBkgd.layer.shadowColor = white.cgColor
        signInBkgd.layer.shadowOpacity = 0.80
        signInBkgd.layer.shadowOffset = CGSize(width: -4, height: -4)
        
        signInBkgd.layer.shadowRadius = 4
        
    
        // sign in button box
        signInBox.layer.cornerRadius = 25
        
        //signInBox.addBkgdShadowToView(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 30, shadowSize: 4)
        
        signInBox.layer.masksToBounds = false
        signInBox.layer.shadowColor = romDarkGray.cgColor
        signInBox.layer.shadowOpacity = 0.3
        signInBox.layer.shadowOffset = CGSize(width: 4, height: 4)
        signInBox.layer.shadowRadius = 4
        
        signInBox.layer.borderColor = palegray.cgColor
        signInBox.layer.borderWidth = 2
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
    
    
    
    // view functions
    
    func checkUserPass(email: String, password: String){
        
        //let urlPath = "http://romadmin.com/checkUserPass.php"
        let urlPath = "https://romdat.com/user/passcheck/"
        //print (urlPath)
        
        let checkEmail = isValidEmail(email)
        //print (checkEmail)
        
        if (checkEmail == true) {
            login(parameters: [email, password], urlString: urlPath)
        }
        else {
            print ("change button")
            self.emailError.text = "bad email address"
            self.emailField.backgroundColor = yellow
            
            //let attributedTitle = signInBtn.attributedTitle(for: .normal)
            //attributedTitle?.setValue("bad email", forKey: "string")
            //signInBtn.setAttributedTitle(attributedTitle, for: .normal)
            
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    func login(parameters : Array<String>, urlString : String)  {
        
        //print (parameters)
        
        var request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
        

        let task = session.dataTask(with: request) { data, response, error in
            //print (data as Any)
            guard let data = data, error == nil else {
                
                print("error: \(String(describing: error))")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    //print (json)
                    
                    let success = json["success"]
                    if (success as! String == "no") {
                        
                        // email not found
                        if json["fail"] as! String == "email" {
                            DispatchQueue.main.async {
                                self.emailError.text = "email not on file"
                                self.emailField.backgroundColor = yellow
                            }
                                print ("login failed email does not exist on file")
                        }
                        
                        // password incorrect
                        if json["fail"] as! String == "password" {
                           DispatchQueue.main.async {
                            if (self.emailField.text == "") {
                                self.emailError.text = "email not on file"
                                self.emailField.backgroundColor = yellow
                            }
                            else {
                                self.emailError.text = ""
                            }
                            self.passwordError.text = "incorrect password"
                            self.passwordField.backgroundColor = yellow
                            }
                            print ("incorrect password for this email")
                        }
                        
                        // user not confirmed code
                        if json["fail"] as! String == "unconfirmed" {
                            
                            userId = json["userId"] as! String
                            
                            DispatchQueue.main.async {
                                self.confirmUser(userid: Int(userId)!)
                            }
                        }
                        
                    }
                    
                    // email and password came back with result
                    if (success as! String == "yes") {
                        
                        userId = json["userId"] as! String
                        myApiKey = json["apikey"] as! String
                        
                       // print (json["userInfo"])
                        print ("User id \(userId) - APIKey \(myApiKey)")
                        
                        DispatchQueue.main.async {
                            
                            self.loginUser(userid: Int(userId)!)
                            
                            
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

    func loginUser(userid: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    }
    
    func confirmUser(userid: Int) {
        // go to Splash IntroViewController
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SplashIntro") as! ConfirmViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    }
    
    

}



