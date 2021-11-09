//
//  ProfileViewController.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 11/9/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import UIKit
import CoreData

 
class ProfileViewController: UIViewController,UITextFieldDelegate, ProfileQuestionProtocol, MyProfileQAProtocol, UIPickerViewDataSource, UIPickerViewDelegate, MyDemosProtocol {
   

    // MARK: download profile info
    
    var myDemoInfo : NSArray = NSArray()
    
    func myDemosDownloaded(demoInfo: NSArray) {
        
        myDemoInfo = demoInfo
        //print (myDemoInfo)
        
        if (myDemoInfo.count > 0) {
            let profile = (myDemoInfo[0] as? MyDemosModel)!
            
            //print (profile)
            // name config
            nickName.text = profile.nickName
            
            firstName.text = profile.nameFirst
            lastName.text = profile.nameLast
            
            displayNickname.text = profile.nickName!
            displayName.text = ("\(profile.nameFirst!) \(profile.nameLast!)")
            
            // async
            if (profile.userImage != "") {
                
                let urlString = "http://romadmin.com/images/users/\(profile.userImage!)"
                print (urlString)
                
                if let url = URL(string: urlString) {
         
                    downloadImage(from: url)
                }
            }
            
            // bday config
            //print (profile.bday)
            if profile.bday! != "0000-00-00" {
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                //if let timeZone = NSTimeZone(abbreviation: "PST") {...
                
                //dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)
                dateFormatter.timeZone = TimeZone(abbreviation: "EST")
                dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
             
                //let birthdate = dateFormatter.date(from: profile.bday!)!
             
               // bday.date = birthdate
                
                //let dob = DateComponents(calendar: .current, year: 2000, month: 6, day: 30).date!
                //let age = dob.age
                let now = Date()
                let calendar = Calendar.current
                //let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
                //let age = ageComponents.year
                
                //displayAge.text = ("My Age is \(age!)")
            }
            
            
            
            if profile.location! != "" {
                myLocation.text = profile.location!
                displayLocation.text = profile.location!
            }
            
            /*if profile.occupation! != "" {
                myOccupation.text = profile.occupation!
            }*/
            
        }
        
    }
    

    
    // nav links
    
    @IBAction func gotoProfile(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let destination = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! ProfileViewController
         destination.modalPresentationStyle = .fullScreen
         self.present(destination, animated: false)
        
    }
    
    
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
    
    
    
    // View vars
    var userInfo: [NSManagedObject] = []
    
    @IBOutlet var profileView: UIView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var profileScrollView: UIScrollView!
    
    // display info
    @IBOutlet weak var displayNickname: UILabel!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayLocation: UILabel!
    @IBOutlet weak var displayAge: UILabel!
    
    
    // user image uploads
    @IBOutlet weak var addPictureBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
  
    //var imagePicker : UIImagePickerController = UIImagePickerController()
    
    
    // save buttons
    @IBOutlet weak var saveBkgd: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    //  text fields
    
    private var currentTextField: UITextField?
    
    @IBOutlet weak var nickName: UITextField! {
        didSet {
            nickName.delegate = self
        }
    }
    
    @IBOutlet weak var firstName: UITextField! {
        didSet {
            firstName.delegate = self
        }
    }
    @IBOutlet weak var lastName: UITextField! {
        didSet {
            lastName.delegate = self
        }
    }
    @IBOutlet weak var myLocation: UITextField! {
        didSet {
            myLocation.delegate = self
        }
    }
    @IBOutlet weak var myOccupation: UITextField! {
        didSet {
            myOccupation.delegate = self
        }
    }
    
     
    // textfield actions
    
    @IBAction func nickNameChanged(_ sender: Any) {
    
        saveUserDemos()
    
    }
    
    @IBAction func firstNameChanged(_ sender: Any) {
       
        saveUserDemos()
    }
    
    @IBAction func lastNameChanged(_ sender: Any) {
       
        saveUserDemos()
    }
    
    @IBAction func editMyLocation(_ sender: Any) {
        
        saveUserDemos()
    }

    @IBAction func editMyOccupation(_ sender: Any) {
       
        saveUserDemos()
    }
    
    
   var demoTextBoxes = [UITextField]()
    
      
    // MARK:  birthday
    
    var birthday: Date = Date()
    
    @IBOutlet weak var bday: UIDatePicker!
    
    @IBAction func saveBday(sender: UIDatePicker) {
        birthday = bday.date
        //print (birthday)
        
        saveUserDemos()
    }
   
    
    // MARK: answer pickers
    
    var pickerList          = [UIPickerView]()
    var pickerOptions       = NSMutableArray()
    var pickerTextBoxes     = [UITextField]()
    var pickerSelections    = [Int:Int]()
    
    
    // MARK: sex
    
    var sexIs: String = ""
    var orientationIs: String = ""

    
    // MARK: icons
    
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var bdayIcon: UIImageView!
    @IBOutlet weak var locationIcon: UIImageView!
    
    
    // MARK:  view did load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // user logs
        if (profileStarted == "") {
            updateUserLogs(userid: userId, item: "profile-started")
        }
       
        // icons
        nameIcon.image       = UIImage(named:"menu-user-gray")
        //bdayIcon.image       = UIImage(named:"menu-calendar-gray")
        locationIcon.image   = UIImage(named:"menu-location-gray")
        //occupationIcon.image = UIImage(named:"menu-account-gray")
        
        nickName.layer.addBorder(edge: .bottom, color: romDarkGray, thickness: 1)
        firstName.layer.addBorder(edge: .bottom, color: romDarkGray, thickness: 1)
        lastName.layer.addBorder(edge: .bottom, color: romDarkGray, thickness: 1)
        myLocation.layer.addBorder(edge: .bottom, color: romDarkGray, thickness: 1)
      
        // user image
        userImage.image = UIImage(named:"profile-placeholder-sq.png")
        userImage.isUserInteractionEnabled = true
        
        userImage.addBkgdShadowToImage(color: romDarkGray, offsetX: 4, offsetY: 4, opacity: 80, shadowSize: 4)
        //picker.delegate = self
        
        bday.isHidden = true
        // age stuff
        //bday.addTarget(self, action: #selector(saveBday), for: .valueChanged)
        
        // bring in user profile
        let myDemo = MyDemos()
        myDemo.delegate = self
        myDemo.downloadMyDemos(userid: userId)
        
        demoTextBoxes.append(nickName)
        demoTextBoxes.append(firstName)
        demoTextBoxes.append(lastName)
        demoTextBoxes.append(myLocation)
        //demoTextBoxes.append(myOccupation)
        
        
        // sign in button bkgds
        saveBkgd.layer.borderColor = white.cgColor
        saveBkgd.layer.borderWidth = 4
        saveBkgd.layer.cornerRadius = 30
        
        saveBkgd.layer.masksToBounds = false
        saveBkgd.layer.shadowColor = white.cgColor
        saveBkgd.layer.shadowOpacity = 0.80
        saveBkgd.layer.shadowOffset = CGSize(width: -4, height: -4)
        saveBkgd.layer.shadowRadius = 4
        
    
        // sign in button box
        saveButton.layer.masksToBounds = false
        saveButton.layer.shadowColor = romDarkGray.cgColor
        saveButton.layer.shadowOpacity = 0.3
        saveButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        saveButton.layer.shadowRadius = 4
        
        saveButton.layer.borderColor = palegray.cgColor
        saveButton.layer.borderWidth = 2
        saveButton.layer.cornerRadius = 30
        
        // bring in profile questions
        let profileQs = ProfileQuestions()
        profileQs.delegate = self
        profileQs.downloadProfileQuestions()
        
        
        self.updateViewConstraints()
        
    }

    
    
    

    func saveUserDemos() {
        if let currentTextField = currentTextField {
            currentTextField.resignFirstResponder()
        }
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let savebday = df.string(from: bday.date)
        
        //print (nickName.text!)
        
        updateUserDemos(userid: userId, nickName: (nickName.text!), nameFirst: (firstName.text!), nameLast: (lastName.text!), bday: savebday, location: (myLocation.text!) )
   
    }
    
    
    // download profile info
    var ProfileQuestionsList : NSArray = NSArray()
    
    func questionsDownloaded(questions: NSArray) {
        
        ProfileQuestionsList = questions
        
        //print (questions)
        
        // bring in user profile
        let myProfileQA = MyProfileQAs()
        myProfileQA.delegate = self
        myProfileQA.downloadMyProfileQAs(userid: userId)
        
    }
    
    
    // download profile info
    var myProfileQAs : NSArray = NSArray()
    
    func myProfileQADownloaded(profileAnswers: NSArray) {
        
        myProfileQAs = profileAnswers
       // print (myProfileQAs)
     
        //printProfileQuestions()
        
        //print (pickerSelections)
        
        pickerSelections.forEach { pickSelect  in
           
            //print (pickSelect.key)
            if pickSelect.value != 0 {
                let thisPicker = pickerList[pickSelect.key-1]
                //print (thisPicker)
                thisPicker.selectRow(pickSelect.value, inComponent: 0, animated: false)
            }
            
        }
        
    }
    
    
    func printProfileQuestions() {
          
        var labelMarker = myLocation.frame.origin.y + 60
        
        for i in 0 ..< ProfileQuestionsList.count {
              
        
            // question label
            
            let pquestion = ProfileQuestionsList[i] as! ProfileQuestionModel

            labelMarker += 20

            var label = UILabel(frame: CGRect(x: CGFloat(0.04 * view.bounds.width), y: CGFloat(labelMarker), width: CGFloat(0.92 * view.bounds.width), height: 20))
            label.text = pquestion.question!
            label.font = UIFont.boldSystemFont(ofSize: 18.0)

            profileScrollView.addSubview(label)

            labelMarker += 30
            
            
            // textField selector tied to pickerView dropdown
            
            let textSelect = UITextField(frame: CGRect(x: 15,y: labelMarker,width: 350, height: 30))
            textSelect.text = ""
            textSelect.placeholder = "Choose your option"
            textSelect.font = UIFont.systemFont(ofSize: 15)
            textSelect.borderStyle = UITextField.BorderStyle.roundedRect
            
            
            // tap select gesture
            let tap = MyTapGesture(target: self, action: #selector(tapSelect))
            
            textSelect.addGestureRecognizer(tap)
            textSelect.isUserInteractionEnabled = true
            
            
            tap.q = String(i)
            
            profileScrollView.addSubview(textSelect)
            
            pickerTextBoxes.append(textSelect)
            
            labelMarker += 30
              
            
            // dropdown picker View
            
            let picker = UIPickerView()
            
            picker.translatesAutoresizingMaskIntoConstraints = false
            
            profileScrollView.addSubview(picker)
            profileScrollView.bringSubview(toFront:picker)
            
            pickerList.append(picker)
            
            
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            picker.tag = i
            
            picker.delegate = self
            picker.dataSource = self
            
            let getTap = GetTapGesture(target: self, action: #selector(tappedMe))
            getTap.tag = i
            getTap.numberOfTapsRequired = 2
            
            picker.addGestureRecognizer(getTap)
            
            
            picker.isHidden = true
            // question
            
            let PQ = pquestion.id!
            let PQO = pquestion.order!
            let PQAnswers = pquestion.answers!

            var pickerOptionList = NSMutableArray()
            
            var pickerOpts = [String: String]()
            
            for l in 0..<PQAnswers.count {
                           
                let answer = PQAnswers[l] as! [String:Any]

                let PQA = answer["profileAnswer_id"]! as! String
                //print (PQA)
                
                pickerOpts["answerId"] = PQA
                pickerOpts["answerText"] = answer["profileAnswer_text"]! as! String
                
                pickerOptionList[l] = pickerOpts
                
                
                var chosen = "no"
                
                // cycle QAs to set default picker and install as text Field
                for q in 0..<myProfileQAs.count {
                 
                    let profQA = myProfileQAs[q] as! MyProfileQAModel
                    
                    if (profQA.pqid! == PQ) {
                        //print ("live question")
                        //print (profQA.pqaid!)
                        
                        if (profQA.pqaid!) == Int(PQA) {
                            chosen = "yes"
                            textSelect.text = pickerOpts["answerText"]
                            
                            pickerSelections[PQO] = l
                            
                            //picker.selectRow(1, inComponent: 0, animated: false)
                        }
                    }
                    
                }
            
                
            }

            pickerOptions[i] = pickerOptionList
            
            
            labelMarker += 20

            //profileScrollView.setNeedsLayout()
            //profileScrollView.setNeedsUpdateConstraints()
            //profileScrollView.updateConstraintsIfNeeded()
         
        } // end question list
        
        // bring pickers to front z-index
        pickerList.forEach { pick in
            profileScrollView.bringSubview(toFront:pick)
        }
        //print (pickerOptions)
        
    } // end print questions
    
      
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        /*
           if pickerView.tag == 0 {
             return 3
               //return pickerOptions[pickerView.tag].count
           } else {
             return 3
               //return pickerOptions[2].count
           }
    */
        let thisPickOpts = pickerOptions[pickerView.tag] as! Array<Any>
        return (thisPickOpts.count)
    }
       
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
            
        let thisPickOpts = pickerOptions[pickerView.tag] as! Array<Any>
        
        //print (thisPickOpts[row])
        let thisPickData = thisPickOpts[row] as! NSDictionary
        let answerText = thisPickData["answerText"] as? String
        
        return answerText
        
    }
       
      
    /*
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let thisPickOpts = pickerOptions[pickerView.tag] as! Array<Any>
        print (thisPickOpts[row])
        let thisPickData = thisPickOpts[row] as! NSDictionary
        let answerid = (thisPickData["answerId"] as? String)!
        
           //self.textBox.text = self.list[row]
           //self.picker.isHidden = true
        
        let textBox = pickerTextBoxes[pickerView.tag]
        textBox.text = thisPickData["answerText"] as? String
        
        pickerView.isHidden = true
        
        let PQ = ProfileQuestionsList[pickerView.tag] as! ProfileQuestionModel
        
        updateUserProfileQuestions(userid: userId, pq: String(PQ.id!), pqa: answerid )
        
    }
    */
    
    
    // MARK:  TextFields
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.backgroundColor = romLightGray // setting a highlight color
        currentTextField = textField
        
        pickerTextBoxes.forEach { tb in
            tb.backgroundColor = white
        }
        
        print (currentTextField?.tag)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear // setting a default color
        
        pickerList.forEach { pick in
            pick.backgroundColor = UIColor.clear
            pick.isHidden = true
        }
        
    }
    
    
    
    // MARK: Saving user data functions
    
    
    func updateUserDemos(userid: String, nickName: String, nameFirst: String, nameLast: String, bday: String, location: String){
        
        //post(parameters: [userid, nickName, nameFirst, nameLast, bday, location], urlString: "https://romdat.com/user/\(userid)/demos/update")
        print ("\(userid), \(nickName), \(nameFirst), \(nameLast), \(bday), \(location)")
        postWithCompletion(parameters: [userid, nickName, nameFirst, nameLast, bday, location], urlString: "https://romdat.com/user/\(userid)/demos/update") { success, result in
        
           print (result)
        }
    }

    
    func saveUserProfile(pq: String, pqa: String) {
          
          updateUserProfileQuestions(userid: userId, pq: pq, pqa: pqa )
     
          // bring in user profile
          let myProfileQA = MyProfileQAs()
          myProfileQA.delegate = self
          myProfileQA.downloadMyProfileQAs(userid: userId)
          
          printProfileQuestions()
          
      }
    
    // MARK: user actions
    
    // when a question is chosen (tapped)
    @objc func tapSelect(sender : MyTapGesture) {
        
        demoTextBoxes.forEach { dtb in
            textFieldShouldReturn(dtb)
            dtb.backgroundColor = white
        }
        
        pickerTextBoxes.forEach { ptb in
            ptb.backgroundColor = white
        }
        
        print ("Question is \(sender.q)")
        
        let Q = Int(sender.q)!
        
        let pick = pickerList[Q]
        let pickOpts = pickerOptions[Q]
        let textBox = pickerTextBoxes[Q]
        
        pick.backgroundColor = lightgray
        pick.isHidden = false
        
        textBox.backgroundColor = coolblue
        
        //print (pick)
        //print (pickOpts)
        //print (sender.qa)
        
        //saveUserProfile(pq: sender.q, pqa: sender.qa)
       
    }
    
    // when a question is chosen (tapped)
     @objc func tappedMe(sender : GetTapGesture) {
         
         let thisPickOpts = pickerOptions[sender.tag] as! Array<Any>
         //print (thisPickOpts[row])
         let pickerView = pickerList[sender.tag]
         let row = pickerView.selectedRow(inComponent: 0)
        
         let thisPickData = thisPickOpts[row] as! NSDictionary
         let answerid = (thisPickData["answerId"] as? String)!
         
            //self.textBox.text = self.list[row]
            //self.picker.isHidden = true
         
         let textBox = pickerTextBoxes[sender.tag]
         textBox.text = thisPickData["answerText"] as? String
         
         pickerView.isHidden = true
         
         let PQ = ProfileQuestionsList[pickerView.tag] as! ProfileQuestionModel
         
         updateUserProfileQuestions(userid: userId, pq: String(PQ.id!), pqa: answerid )
        
     }
     
     
     class MyTapGesture: UITapGestureRecognizer {
         var q = String()
         var qa = String()
    
     }
    
    class GetTapGesture: UITapGestureRecognizer {
        var tag = Int()
    }
    
    
    // MARK:  for button choices
    
    /*
    func didSelectButton(selectedButton: UIButton?) {
        
        switch selectedButton!.tag {
            case 1:
                sexIs = "male"
            
            case 2:
                sexIs = "female"
            
            case 3:
                sexIs = "other"
            
            case 4:
                orientationIs = "straight"
            
            case 5:
                orientationIs = "gay"
            
            case 6:
                orientationIs = "bisexual"
            
            case 7:
                orientationIs = "pansexual"
            
            case 8:
                orientationIs = "asexual"
            
            case 9:
                orientationIs = "other"
            
            default:
                orientationIs = "other"
        }
        
        print (sexIs)
        print (orientationIs)
        saveUserDemos()
        
    }
    */
    
    
    
    
    // MARK: image downloading
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print (data)
            print("Download Finished")
            
            // try to fetch the user image
            DispatchQueue.main.async() {
                
                if UIImage(data: data) != nil {
                    
                    self.userImage.image = UIImage(data: data)
                
                }
            }
        }
    }
    
    
    
    // MARK: picture gallery functions
    
    @IBAction func addPictureBtnAction(sender: UIButton) {

        addPictureBtn.isEnabled = false

        let alertController : UIAlertController = UIAlertController(title: "Upload Profile Image", message: "Select Camera or Photo Library", preferredStyle: .actionSheet)
        
        // camera picker
        let cameraAction : UIAlertAction = UIAlertAction(title: "Camera", style: .default, handler: {(cameraAction) in
            print("camera Selected...")

            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) == true {

                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                imagePicker.delegate = self
                       
                self.present(imagePicker, animated: true, completion: nil)
                
                //self.imagePicker.sourceType = .camera
                //self.imagePicker.delegate = self
                //self.present()

            }else{
                //self.presentViewController(self.showAlert("Title", Message: "Camera is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)

            }

        })

        // library picker
        let libraryAction : UIAlertAction = UIAlertAction(title: "Photo Library", style: .default, handler: {(libraryAction) in

            print("Photo library selected....")

            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) == true {
                
                let imagePicker = UIImagePickerController()
                       
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                
                imagePicker.delegate = self
                      
                self.present(imagePicker, animated: true, completion: nil)
                print ("ok presented")
                //self.present()

            } else{

        //self.presentViewController(self.showAlert("Title", Message: "Photo Library is not available on this Device or accesibility has been revoked!"), animated: true, completion: nil)
            }
        })

        let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel , handler: {(cancelActn) in
        print("Cancel action was pressed")
        })

        alertController.addAction(cameraAction)
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)

        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = view.frame

        self.present(alertController, animated: true, completion: nil)


    }

/*
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
     {
           
       // let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //userImage.image = chosenImage
        //dismiss(animated:true, completion: nil)
        
        uploadImage()
        
           // print ("I'm here")
            //print (info)
        //self.delegate.uploadImage(image: image)
        /*if let selectedImage = info[.originalImage] as! UIImage {
                
                print (selectedImage)
            }
           */
        
        //let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        //let imageData:Data = UIImagePNGRepresentation(image_data)!
        //let imageStr = imageData.base64EncodedString()
        
         //print("info of the pic reached :\(info) ")
        
        //self.imagePicker.dismiss(animated: true, completion: nil)

    }
    
    */
    
    
    // MARK: image uploading
    
    func uploadImage(image: UIImage) -> Void{
        //Convert the image to a data blob
        guard let png = UIImagePNGRepresentation(image) else{
            print("error")
            return
        }
        
        let url = URL(string: "https://romdat.com/user/\(userId)/avatar/")
        
        
        print (url)
        

        //Set up a network request
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        //request.url = NSURL(string: "http://127.0.0.1:5000/") as URL?
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("\(png.count)", forHTTPHeaderField: "Content-Length")
        request.httpBody = png
        // Figure out what the request is making and the encoding type...

        
        let upload = URLSession.shared.uploadTask(with: request as URLRequest, from: png) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print (data)
            
            self.parseJSON(data!)
            
        }
        

        upload.resume()

    }
    
    
    func uploadImageOld(image: UIImage) {
        
        //let imageData:Data = UIImagePNGRepresentation(image)!
        //let imageStr = imageData.base64EncodedString()
    
        userImage.image = image
        
        
        //let url = URL(string: "http://romational.com/app/uploadUserImage.php")
        let url = URL(string: "http://www.romadmin.com/uploadUserImage.php")
        
        print (url)
    
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
    
        let boundary = "Boundary-\(NSUUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let imageData = UIImageJPEGRepresentation(image, 1)
        if (imageData == nil) {
            print("UIImageJPEGRepresentation return nil")
            return
        }
        
        /*
        var retrievedImage: UIImage? = nil
        
        // Get camera image??
        do {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let readData = try Data(contentsOf: URL(string: "file://\(documentsPath)/myImage")!)
            retrievedImage = UIImage(data: readData)
            userImage.image = retrievedImage //addProfilePicView.setImage(retreivedImage, for: .normal)
        }
        catch {
            print("Error while opening image")
            return
        }

        
        
       let imageData = UIImageJPEGRepresentation(image!, 1)
       if (imageData == nil) {
           print("UIImageJPEGRepresentation return nil")
           return
       }
*/
        
       let userImage =  "user-\(userId)-profile.jpg"
       let mimetype = "image/jpg"

       let body = NSMutableData()
        
       body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
       body.append(NSString(format: "Content-Disposition: form-data; name=\"userId\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
       body.append(NSString(format: (userId as NSString)).data(using: String.Encoding.utf8.rawValue)!)
        
       body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
       body.append(NSString(format:"Content-Disposition: form-data; name=\"file\"; filename=\"\(userImage)\"\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
       body.append(NSString(format: "Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        
 
       body.append(imageData!)
       //body.append(imageData!)
        
       body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)

       request.httpBody = body as Data

        //print (body)
        
       // upload activity spinner
       showSpinner(onView: profileView)
        
       let task =  URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
           (data, response, error) -> Void in
           
        print (data)
        
            if let data = data {
              // do what you want in success case
            
                var jsonResult = NSDictionary()
                
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                } catch let error as NSError {
                    print(error)
                    
                }
                
                print (jsonResult)
            
                //print (data)
                self.removeSpinner()
                
                print ("image uploaded")
            
           } else if let error = error {
               print(error.localizedDescription)
           }
       })

       task.resume()
   }
    
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        print (jsonResult)
        
    }
    
}




// extensions to use the image picker controller delegate properly

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("\(info)")

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //userImage.image = image
            print ("The image is \(image)")
            
            dismiss(animated: true, completion: nil)
            
            // upload the image
            uploadImageOld(image: image)
            //uploadImage(image: image)
        }
    }
}



// this update function lives down here because it is also used on obsolete introSurveyViewController
func updateUserProfileQuestions(userid: String, pq: String, pqa: String){
    
    print (userid)
    print (pq)
    print (pqa)
    //post(parameters: [userid, pq, pqa], urlString: "http://romadmin.com/updateUserProfileQuestions.php")
    post(parameters: [userid, pq, pqa], urlString: "https://romdat.com/user/\(userid)/profiles/update/")
}


