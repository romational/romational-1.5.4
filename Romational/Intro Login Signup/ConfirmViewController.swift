//
//  SplashViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 4/14/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet var splashBkgd: UIView!
    @IBOutlet weak var splashLogo: UIImageView!
    
    @IBOutlet weak var splashIntro: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: buttons
    
    @IBOutlet weak var mainMenuButton: UIButton!
    @IBOutlet weak var introSurveyButton: UIButton!

    
    @IBOutlet weak var codeBox: UIView!
    
    var codes = [UITextField]()
    
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var code5: UITextField!
    @IBOutlet weak var code6: UITextField!
    
   
    var buttons = [UIButton]()
    
    
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func submitCode(_ sender: Any) {
    
        if (code1.text != "") {
            confirmUser()
        }
        else {
            submitButton.setTitle("Enter Code", for: .normal)
            submitButton.backgroundColor = romRed
        }
        
    }
    
    
    @IBAction func resetEntry(_ sender: Any) {
   
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "SplashIntro") as! ConfirmViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: true)
    }
    
    @IBOutlet weak var resend: UIButton!
    
    @IBAction func resendCode(_ sender: Any) {
    
        resendConfirmationCode(userid: userId)
        resend.isEnabled = false
    }
    
    
    @IBAction func gotoMainMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    
    }
    
    @IBAction func gotoProfile(_ sender: Any) {
    
         let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    

    @IBAction func gotoIntroSurvey(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "IntroSurvey") as! IntroSurveyViewController
    navigationController?.pushViewController(destination, animated: true)
        //self.present(controller, animated: true, completion: nil)
    }
    
    
    // MARK: view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //splashBkgd.backgroundColor = UIColor(patternImage: UIImage(named: "gray-clouds.png")!)
        
        //splashLogo.image = UIImage(named: "romational-logo-v2.png")
        
        let pageInfo = VCS["SplashIntro"] as? VCSInfoModel
        
        if (pageInfo?.info != nil) {
             
            splashIntro.text = pageInfo!.info
        }
       
        codeBox.layer.masksToBounds = false
        codeBox.layer.shadowColor = romDarkGray.cgColor
        codeBox.layer.shadowOpacity = 0.3
        codeBox.layer.shadowOffset = CGSize(width: 4, height: 4)
        codeBox.layer.shadowRadius = 4
        codeBox.layer.cornerRadius = 20
        
        //MARK: enter code numbers fields
        
        codes.append(code1)
        codes.append(code2)
        codes.append(code3)
        codes.append(code4)
        codes.append(code5)
        codes.append(code6)
        
        codes.forEach { cd in
            cd.backgroundColor = romTeal
            cd.delegate = self
            cd.keyboardType = .numberPad
            cd.addTarget(self, action: #selector(ConfirmViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
        
        // MARK: button array
        
        buttons.append(mainMenuButton)
        buttons.append(introSurveyButton)
       
        // add styling
        buttons.forEach { button in
            button.isEnabled = false
            button.isHidden = true
            button.layer.masksToBounds = false
            button.layer.shadowColor = romDarkGray.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowOffset = CGSize(width: 4, height: 4)
            button.layer.shadowRadius = 4
        
            button.layer.cornerRadius = 30
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    // limit text fields to 1 char
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        self.switchBasedNextTextField(textField)
        return true
    
    }
    
    
    @objc func textFieldDidChange(_ textField : UITextField) {
       let newLength = textField.text?.count
       
        print (newLength)
        
        if newLength == 1 {
            self.switchBasedNextTextField(textField)
        }
      
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.code1:
            self.code2.becomeFirstResponder()
        case self.code2:
            self.code3.becomeFirstResponder()
        case self.code3:
            self.code4.becomeFirstResponder()
        case self.code4:
            self.code5.becomeFirstResponder()
        case self.code5:
            self.code6.becomeFirstResponder()
        case self.code6:
            self.code6.resignFirstResponder()
        default:
            self.code6.resignFirstResponder()
        }
    }
    
    
    func confirmUser() {
        
        let codeToSubmit = ("\(code1.text!)\( code2.text!)\(code3.text!)\(code4.text!)\(code5.text!)\(code6.text!)")
        
        print (codeToSubmit)
        
        //let urlPath = "http://romadmin.com/confirmUser.php?userId=\(userId)&code=\(codeToSubmit)"
        let urlPath = "https://romdat.com/user/\(userId)/codecheck/\(codeToSubmit)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to confirm")
            }
            else {
                print("Confirm results")
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
        
        print (jsonResult)
        
        if jsonResult["success"] as! String == "yes" {
            DispatchQueue.main.async(execute: { () -> Void in
            
               
                self.submitButton.setTitle("Confirmed", for: .normal)
                self.submitButton.backgroundColor = green
                self.codeBox.backgroundColor = romTeal
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "MainMenu") as! MainMenuViewController
                destination.modalPresentationStyle = .fullScreen
                self.present(destination, animated: false)
                
                /*
                // scroll down to buttons
                let point = self.codeBox.frame.origin
                self.scrollView.contentOffset = point
                
                // turn on buttons
                self.buttons.forEach { btn in
                    btn.isEnabled = true
                    btn.isHidden = false
                    btn.backgroundColor = white
                }
                */
                
            })
        }
        else {
            DispatchQueue.main.async(execute: { () -> Void in
            
                self.submitButton.setTitle("Code Failed", for: .normal)
                self.submitButton.backgroundColor = orange
            })
        }
        
        
    }
    
   
    // send confirm - outside class so confirm view can use it too
    func resendConfirmationCode(userid: String){
        
        //post(parameters: [userid], urlString: "http://romadmin.com/resendCode.php")
        //post(parameters: [userid], urlString: "https://romdat.com/user/\(userid)/sendpincode/")

        postWithCompletion(parameters: [userId], urlString: "https://romdat.com/user/\(userid)/sendpincode/") { success, result in
            
            print (result)
            
            if result["success"] as! String == "yes" {
                
                print ("code sent")
                self.resend.setTitle("Sent", for: .normal)
                self.resend.setTitleColor(white, for: .normal)
                self.resend.layer.backgroundColor = romPink.cgColor
            }
            
        }
        
    }
    
}
