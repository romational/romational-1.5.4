//
//  EnterCodeViewController.swift
//  Romational
//
//  Created by Cedarleaf on 11/22/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class EnterCodeViewController: UIViewController, UITextFieldDelegate {

    
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
    
        slideController = storyboard!.instantiateViewController(withIdentifier: "UserOptions") as? UserOptionsViewController
           
            
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
        self.slideController.didMove(toParent: self)
            
        showMenu = true
       
    }
    
    
    @IBAction func goToStartConnect(_ sender: Any) {
    
        //let compareURL = URL(string: messageLabel.text!)!
        //let compareUserId = compareURL.valueOf("userId")!
        
        let codeToSubmit = ("\(code1.text!)\( code2.text!)\(code3.text!)\(code4.text!)\(code5.text!)\(code6.text!)")
        
        //print (codeToSubmit)
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "CompareIntro") as! CompareIntroViewController
        
        //destination.qrcodeString = messageLabel.text!
        destination.romMeCode = codeToSubmit
        
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    
    @IBOutlet var codeBox: UIView!
    
    @IBOutlet weak var code1: UITextField!
    @IBOutlet weak var code2: UITextField!
    @IBOutlet weak var code3: UITextField!
    @IBOutlet weak var code4: UITextField!
    @IBOutlet weak var code5: UITextField!
    @IBOutlet weak var code6: UITextField!
    
    var codes = [UITextField]()
    
    @IBOutlet weak var startButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeBox.layer.cornerRadius = 20
        
        //MARK: enter code numbers fields
        
        codes.append(code1)
        codes.append(code2)
        codes.append(code3)
        codes.append(code4)
        codes.append(code5)
        codes.append(code6)
        
        codes.forEach { cd in
            //cd.backgroundColor = romTeal
            cd.delegate = self
            cd.keyboardType = .numberPad
            cd.addTarget(self, action: #selector(EnterCodeViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
        
        
        startButton.layer.masksToBounds = false
        startButton.layer.shadowColor = romDarkGray.cgColor
        startButton.layer.shadowOpacity = 0.3
        startButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        startButton.layer.shadowRadius = 4
        startButton.layer.borderColor = palegray.cgColor
        startButton.layer.borderWidth = 2
        startButton.layer.cornerRadius = 30
        
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
}
