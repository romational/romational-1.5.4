//
//  SignupViewController.swift
//  Charts
//
//  Created by Nicholas Zen Paholo on 7/8/20.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    
    // nav
    @IBAction func gotoLogin (_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet weak var signUpTitle: UILabel!
    @IBOutlet weak var signUpIntro: UILabel!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBAction func btn_box(sender: UIButton) {
        if (checkboxButton.isSelected == true)
        {
            checkboxButton.setBackgroundImage(UIImage(named: "checkbox-empty"), for: .normal)

            checkboxButton.isSelected = false;
        }
        else
        {
            checkboxButton.setBackgroundImage(UIImage(named: "checkbox-marked"), for: .normal)

            checkboxButton.isSelected = true;
        }
    }
    
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmError: UILabel!
    @IBOutlet weak var confirmAgeError: UILabel!
    
    @IBOutlet weak var createBkgd: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    @IBAction func createAccount(_ sender: Any) {
        
        nameError.text = ""
        emailError.text = ""
        passwordError.text = ""
        confirmError.text = ""
        
        var valid = "yes"
        
        
        if (firstNameField.text == "") {
            valid = "no"
            nameError.text = "No first name"
        }
        if (lastNameField.text == "") {
            valid = "no"
            nameError.text = "No last name"
        }
        if (emailField.text == "") {
            valid = "no"
            emailError.text = "No email"
        }
        if (passwordField.text!.isAlphanumeric == false) {
            valid = "no"
            passwordError.text = "Password must be alphanumeric"
        }
        if (passwordField.text!.count < 6 ) {
            valid = "no"
            passwordError.text = "Password must be 6+ characters"
        }
        if (passwordField.text == "") {
            valid = "no"
            passwordError.text = "No password"
        }
        if (confirmField.text == "") {
            valid = "no"
            confirmError.text = "Confirm password"
        }
        if (confirmField.text != passwordField.text) {
            valid = "no"
            confirmError.text = "Password mis-match"
        }
        
        if checkboxButton.isSelected != true {
            valid = "no"
            confirmAgeError.text = "Confirm You Are 18+ Years Old"
            confirmAgeError.textColor = red
        }
        
        if valid == "yes" {
            createUser(firstName: firstNameField.text!, lastName: lastNameField.text!, email: emailField.text!, password: passwordField.text!)
        }
        
    }
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        let pageInfo = VCS["Signup"] as? VCSInfoModel
        
         if (pageInfo?.title != nil) {
            //signUpTitle.text = pageInfo!.title
         }
         if (pageInfo?.info != nil) {
             
             signUpIntro.text = pageInfo!.info
         }
        
        // hook up the textfield delegates for highlighting
        firstNameField.delegate = self
        lastNameField.delegate  = self
        emailField.delegate     = self
        passwordField.delegate  = self
        confirmField.delegate   = self
        
        checkboxButton.setBackgroundImage(UIImage(named: "checkbox-empty"), for: .normal)

        checkboxButton.isSelected = false;
        
        // style the fields (v4)
        firstNameField.addBottomBorder(height: 1, color: romDarkGray)
        lastNameField.addBottomBorder(height: 1, color: romDarkGray)
        emailField.addBottomBorder(height: 1, color: romDarkGray)
        passwordField.addBottomBorder(height: 1, color: romDarkGray)
        confirmField.addBottomBorder(height: 1, color: romDarkGray)
        
        firstNameField.layer.cornerRadius = 20
        lastNameField.layer.cornerRadius = 20
        emailField.layer.cornerRadius = 20
        passwordField.layer.cornerRadius = 20
        confirmField.layer.cornerRadius = 20
        
        firstNameField.setLeftPaddingPoints(20)
        lastNameField.setLeftPaddingPoints(20)
        emailField.setLeftPaddingPoints(20)
        passwordField.setLeftPaddingPoints(20)
        confirmField.setLeftPaddingPoints(20)
        
        // use password security
        passwordField.isSecureTextEntry = true
        confirmField.isSecureTextEntry = true
        
        // create button
        createBkgd.layer.masksToBounds = false
        createBkgd.layer.shadowColor = white.cgColor
        createBkgd.layer.shadowOpacity = 0.8
        createBkgd.layer.shadowOffset = CGSize(width: -4, height: -4)
        createBkgd.layer.shadowRadius = 4
        
        //createBkgd.layer.borderColor = palegray.cgColor
        //createBkgd.layer.borderWidth = 2
        createBkgd.layer.cornerRadius = 30
        
        createButton.layer.masksToBounds = false
        createButton.layer.shadowColor = romDarkGray.cgColor
        createButton.layer.shadowOpacity = 0.3
        createButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        createButton.layer.shadowRadius = 4
    
        createButton.layer.cornerRadius = 30
        
        
        
        
    }
    

    
    func createUser(firstName: String, lastName: String, email: String, password: String){
        
        addUser(parameters: [firstName, lastName, email, password], urlString: "https://romdat.com/user/add/")
        
        
    }

    func addUser(parameters : Array<String>, urlString : String)  {
        
        print (parameters)
        
        var request = URLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
        
        //print (request.httpBody!)

        let task = session.dataTask(with: request) { data, response, error in
            //print (data as Any)
            guard let data = data, error == nil else {
                
                print("error: \(String(describing: error))")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let success = json["success"]
                    
                    print (json)
                    
                    if success as! String == "no" {
                        
                        if json["response"] as! String == "duplicate" {
                            DispatchQueue.main.async {
                                self.emailError.text = "duplicate email"
                                let newTitle = NSMutableAttributedString(string: "email error")
                                self.createButton.setAttributedTitle(newTitle, for: .normal)
                                self.createButton.backgroundColor = orange
                            }
                        }
                        else {
                        
                            DispatchQueue.main.async {
                                self.confirmError.text = "Sign Up Failed"
                                let newTitle = NSMutableAttributedString(string: "sign up failed")
                                self.createButton.setAttributedTitle(newTitle, for: .normal)
                                self.createButton.backgroundColor = orange
                            }
                        }
                        
                    }
                    
                    if success as! String == "yes" {
                        
                        DispatchQueue.main.async {
                            // set user Id
                            print (userId)
                            print (json["userId"])
                            userId = String(json["userId"] as! Int)
                            print (userId)
                            
                            DispatchQueue.main.async {
                                
                                updateUserLogs(userid: userId, item: "user-joined" )
                                
                            }
                            
                            // go to Splash IntroViewController
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                            let destination = storyboard.instantiateViewController(withIdentifier: "SplashIntro") as! ConfirmViewController
                            destination.modalPresentationStyle = .fullScreen
                            self.present(destination, animated: true)
                        }
                        
                    }
                    
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
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 20
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // default color
        textField.layer.borderWidth = 0
        
        textField.addBottomBorder(height: 1, color: romDarkGray)
        textField.backgroundColor = UIColor.clear
        
        textField.layer.cornerRadius = 20
    }
    

}


