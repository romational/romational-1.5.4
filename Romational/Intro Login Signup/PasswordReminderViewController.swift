//
//  PasswordReminderViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/21/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class PasswordReminderViewController: UIViewController {

    
    // nav
    @IBAction func gotoLogin (_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    
    // view vars
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var navBar: UIView!
    
    
    // view buttons
    @IBOutlet weak var reminderButton: UIButton!
    
    @IBAction func sendReminder(_ sender: UIButton) {
        
        reminderButton.backgroundColor = coolblue
        let newTitle = NSAttributedString(string: "Check your Email")
        sender.setAttributedTitle(newTitle, for: .normal)
        
        sendPasswordReminder(email: enterEmail.text!)
        
    }
    
    
    // load view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // button shadow
        reminderButton.layer.cornerRadius = 20
        reminderButton.layer.masksToBounds = false
        reminderButton.layer.shadowColor = romDarkGray.cgColor
        reminderButton.layer.shadowOpacity = 0.3
        reminderButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        reminderButton.layer.shadowRadius = 4
        
        
        enterEmail.addBottomBorder(height: 1, color: romDarkGray)
        
    }
    
    
    // view functions
    
    func sendPasswordReminder(email: String) {
    
        //post(parameters: [email], urlString: "http://romadmin.com/sendPasswordReminder.php")
        post(parameters: [email], urlString: "https://romdat.com/user/passreminder/")

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
