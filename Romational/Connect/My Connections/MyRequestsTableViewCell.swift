//
//  MyRequestsTableViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/15/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//



import UIKit

class MyRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var upNextButton: UIButton!
    
    @IBOutlet weak var introStatus: UILabel!
    @IBOutlet weak var romtypeStatus: UILabel!
    @IBOutlet weak var factorStatus: UILabel!
    @IBOutlet weak var fullStatus: UILabel!
    
    @IBOutlet weak var introStatusThem: UILabel!
    @IBOutlet weak var romtypeStatusThem: UILabel!
    @IBOutlet weak var factorStatusThem: UILabel!
    @IBOutlet weak var fullStatusThem: UILabel!
    
    @IBOutlet weak var introButton: UIButton!
    @IBOutlet weak var romtypeButton: UIButton!
    @IBOutlet weak var factorsButton: UIButton!
    @IBOutlet weak var fullButton: UIButton!
    
    
    
    func displayMyRequests (thisCompareUserId: Int, thisUserName: String, thisUserImage: String, thisIntroStatusMe: String, thisRomtypeStatusMe: String, thisFactorStatusMe: String, thisFullStatusMe: String, thisIntroStatusThem: String, thisRomtypeStatusThem: String, thisFactorStatusThem: String, thisFullStatusThem: String) {
        
        userName.text       = thisUserName
        
        introStatus.text    = thisIntroStatusMe
        romtypeStatus.text  = thisRomtypeStatusMe
        factorStatus.text   = thisFactorStatusMe
        fullStatus.text     = thisFullStatusMe
        
        introStatusThem.text    = thisIntroStatusThem
        romtypeStatusThem.text  = thisRomtypeStatusThem
        factorStatusThem.text   = thisFactorStatusThem
        fullStatusThem.text     = thisFullStatusThem
        
        introButton.tag     = thisCompareUserId
        romtypeButton.tag   = thisCompareUserId
        factorsButton.tag   = thisCompareUserId
        fullButton.tag      = thisCompareUserId
        
        
        if (thisIntroStatusMe == "undecided") || (thisIntroStatusMe == "new") {
           // introButton.layer.backgroundColor = romPink.cgColor
           // introButton.setTitleColor(white, for: .normal)
           // introButton.layer.cornerRadius = 10
        }
        if (thisRomtypeStatusMe == "undecided") || (thisRomtypeStatusMe == "new") {
           // romtypeButton.layer.backgroundColor = romPink.cgColor
           // romtypeButton.setTitleColor(white, for: .normal)
           // romtypeButton.layer.cornerRadius = 10
        }
        if (thisFactorStatusMe == "undecided") || (thisFactorStatusMe == "new") {
           // factorsButton.layer.backgroundColor = romPink.cgColor
           // factorsButton.setTitleColor(white, for: .normal)
           // factorsButton.layer.cornerRadius = 10
        }
        if (thisFullStatusMe == "undecided") || (thisFullStatusMe == "new") {
           // fullButton.layer.backgroundColor = romPink.cgColor
           // fullButton.setTitleColor(white, for: .normal)
           // fullButton.layer.cornerRadius = 10
        }
        
        // reword buttons
        if thisIntroStatusMe == "new" {
            introStatus.textColor = romRed
            romtypeStatus.text = "locked"
            factorStatus.text = "locked"
            fullStatusThem.text = "locked"
        }
        else if thisRomtypeStatusMe == "new" {
            romtypeStatus.textColor = romRed
            factorStatus.text = "locked"
            fullStatusThem.text = "locked"
        }
        else if thisFactorStatusMe == "new" {
            factorStatus.textColor = romRed
            fullStatus.text = "locked"
        }
        else if thisFullStatusMe == "new" {
            fullStatus.textColor = romRed
            
        }
        
        if thisIntroStatusThem == "new" || thisIntroStatusThem == "undecided" {
            introStatusThem.textColor = romRed
            romtypeStatusThem.text = "locked"
            factorStatusThem.text = "locked"
            fullStatusThem.text = "locked"
        }
        else if thisRomtypeStatusThem == "new" || thisRomtypeStatusThem == "undecided" {
            romtypeStatusThem.textColor = romRed
            factorStatusThem.text = "locked"
            fullStatusThem.text = "locked"
        }
        else if thisFactorStatusThem == "new" || thisFactorStatusThem == "undecided" {
            factorStatusThem.textColor = romRed
            fullStatusThem.text = "locked"
        }
        else if thisFullStatusThem == "new" {
            fullStatusThem.textColor = romRed
            
        }
        
        
        // async
        let urlString = "http://romadmin.com/images/users/\(thisUserImage)"
        print (urlString)
        if let url = URL(string: urlString) {
 
            //downloadImage(from: url)
        }
        
    }
    
    // default functions (keep?)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

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
            DispatchQueue.main.async() {
                
                self.userImage.image = UIImage(data: data)
            }
        }
    }
    
}

