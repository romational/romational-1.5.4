//
//  MyRomtypeDataViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 5/6/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit

class MyRomtypeDataViewController: UIViewController {

    
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
        self.slideController.didMove(toParent: self)
            
        showMenu = true
       
    }
    
    @IBAction func myFactorData(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "MyFactorData") as! MyFactorDataViewController
        destination.modalPresentationStyle = .fullScreen
        self.present(destination, animated: false)
    }
    
    
    // download report share
  
    @IBOutlet weak var shareIcon: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareOptions(_ sender: Any) {
   
        let alertController:UIAlertController = UIAlertController(title: "Sharing Options", message: "Select from Below", preferredStyle: UIAlertController.Style.alert)

         
         // add second button (with controller link)
         alertController.addAction(UIAlertAction(title: "View Report", style: .default, handler: { (action) in
         
             self.getPDFlink()

         }))
        
         // add second button (with controller link)
         alertController.addAction(UIAlertAction(title: "Email Report", style: .default, handler: { (action) in
         
             self.emailPDFlink()
             
         }))
        
        /*
        // add second button (with controller link)
        alertController.addAction(UIAlertAction(title: "Share Image", style: .default, handler: { (action) in
        
            var design = "default"
            
            let innerAlert:UIAlertController = UIAlertController(title: "Shareable Image", message: "Choose Your Design", preferredStyle: UIAlertController.Style.alert)
            
            // add second button (with controller link)
            innerAlert.addAction(UIAlertAction(title: "Normal", style: .default, handler: { (action) in
                design = "normal"
                let shareImageURL = "http://romadmin.com/createShareImage.php?userId=\(userId)&design=\(design)"
                
                DispatchQueue.main.async(execute: { () -> Void in
                    UIApplication.shared.openURL(URL(string: shareImageURL)!)
                    
                })

            }))
           
            innerAlert.addAction(UIAlertAction(title: "Retro 80s", style: .default, handler: { (action) in
                design = "abstract"
                let shareImageURL = "http://romadmin.com/createShareImage.php?userId=\(userId)&design=\(design)"
                
                DispatchQueue.main.async(execute: { () -> Void in
                    UIApplication.shared.openURL(URL(string: shareImageURL)!)
                    
                })

            }))
  
            
            innerAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
               

            }))
            
            
            
            self.present(innerAlert, animated: true, completion: nil)
            
           
            
        }))
        */
        
        

        
        alertController.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action) in
               
                   
        }))
        
        present(alertController, animated: true, completion: nil)
        
    }

    
    // view vars
    
    @IBOutlet weak var navBar: UIView!
    
    
    // load view
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load page details
        let pageInfo = VCS["MyRomtypeData"] as? VCSInfoModel
        
         if (pageInfo?.title != nil) {
             
             //myAnswerTitle.text = pageInfo!.title
         }
        
 
        
    }
    

   
    
    
    func emailPDFlink() {
        let urlPath = "http://romadmin.com/createEmailPDF.php?userid=\(userId)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("PDF emailed ")
                print (data)
                DispatchQueue.main.async(execute: { () -> Void in
                
                    self.shareButton.setTitle("Emailed", for: .normal)
                    self.shareButton.backgroundColor = orange
                    self.shareButton.setTitleColor(white, for: .normal)
                    self.shareButton.tintColor = white
                    self.shareButton.layer.cornerRadius = 20
                    
                    /*
                    self.shareButton.setImage(nil, for: .normal)
                    self.shareButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
                    self.shareButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
                    self.shareButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
                    */
                    
                    self.view.setNeedsLayout()
                    
                })
                
            }
            
        }
        
        task.resume()
    }
    
    
    func getPDFlink() {
        let urlPath = "http://www.romadmin.com/createPDF.php?userid=\(userId)"
        
        let url: URL = URL(string: urlPath)!
        
        var request = URLRequest(url: url)
        request.addValue(myApiKey, forHTTPHeaderField: "APIKey")
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("PDF link created")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.parseJSON(data!)
                })
            }
            
        }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = String()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! String
            
        } catch let error as NSError {
            print(error)
            
        }
        
        if jsonResult != "" {
            let pdflink = jsonResult
            print (pdflink)
            DispatchQueue.main.async(execute: { () -> Void in

                // go to the link for the PDF report
                //UIApplication.shared.openURL(URL(string: pdflink)!)
                guard let url = URL(string: pdflink) else {
                  return //be safe
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
        }
    }

}
