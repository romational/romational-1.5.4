//
//  MyComparesTableViewCell.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 7/8/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import UIKit

class MyComparesTableViewCell: UITableViewCell {

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
    
    var buttons = [UIButton]()
    
    func displayMyCompares (thisUserId: Int, thisUserName: String, thisUserImage: String, thisIntroStatusMe: String, thisRomtypeStatusMe: String, thisFactorStatusMe: String, thisFullStatusMe: String, thisIntroStatusThem: String, thisRomtypeStatusThem: String, thisFactorStatusThem: String, thisFullStatusThem: String) {
        
        userName.text       = thisUserName
        
        introStatus.text    = thisIntroStatusMe
        romtypeStatus.text  = thisRomtypeStatusMe
        factorStatus.text   = thisFactorStatusMe
        fullStatus.text     = thisFullStatusMe
        
        introStatusThem.text    = thisIntroStatusThem
        romtypeStatusThem.text  = thisRomtypeStatusThem
        factorStatusThem.text   = thisFactorStatusThem
        fullStatusThem.text     = thisFullStatusThem
        
        introButton.tag     = thisUserId
        romtypeButton.tag   = thisUserId
        factorsButton.tag   = thisUserId
        fullButton.tag      = thisUserId
        
        buttons.append(introButton)
        buttons.append(romtypeButton)
        buttons.append(factorsButton)
        buttons.append(fullButton)
        
        
        if (thisIntroStatusMe == "undecided") || (thisIntroStatusMe == "new") {
            //introButton.layer.backgroundColor = romPink.cgColor
            //introButton.setTitleColor(white, for: .normal)
            //introButton.layer.cornerRadius = 10
        }
        if (thisRomtypeStatusMe == "undecided") || (thisRomtypeStatusMe == "new") {
            //romtypeButton.layer.backgroundColor = romPink.cgColor
            //romtypeButton.setTitleColor(white, for: .normal)
            //romtypeButton.layer.cornerRadius = 10
        }
        if (thisFactorStatusMe == "undecided") || (thisFactorStatusMe == "new") {
            //factorsButton.layer.backgroundColor = romPink.cgColor
            //factorsButton.setTitleColor(white, for: .normal)
            //factorsButton.layer.cornerRadius = 10
        }
        if (thisFullStatusMe == "undecided") || (thisFullStatusMe == "new") {
            //fullButton.layer.backgroundColor = romPink.cgColor
            //fullButton.setTitleColor(white, for: .normal)
            //fullButton.layer.cornerRadius = 10
        }
        
        // reword buttons
        if thisIntroStatusMe == "new" {
            introStatus.textColor = romRed
            romtypeStatus.text = "locked"
            factorStatus.text = "locked"
            fullStatus.text = "locked"
        }
        else if thisRomtypeStatusMe == "new" {
            romtypeStatus.textColor = romRed
            factorStatus.text = "locked"
            fullStatus.text = "locked"
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
                
               /* self.cropToBounds(image: self.userImage.image!, width: 80, height: 80)*/
            }
        }
    }
    
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

            let cgimage = image.cgImage!
            let contextImage: UIImage = UIImage(cgImage: cgimage)
            let contextSize: CGSize = contextImage.size
            var posX: CGFloat = 0.0
            var posY: CGFloat = 0.0
            var cgwidth: CGFloat = CGFloat(width)
            var cgheight: CGFloat = CGFloat(height)

            // See what size is longer and create the center off of that
            if contextSize.width > contextSize.height {
                posX = ((contextSize.width - contextSize.height) / 2)
                posY = 0
                cgwidth = contextSize.height
                cgheight = contextSize.height
            } else {
                posX = 0
                posY = ((contextSize.height - contextSize.width) / 2)
                cgwidth = contextSize.width
                cgheight = contextSize.width
            }

            let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

            // Create bitmap image from context using the rect
            let imageRef: CGImage = cgimage.cropping(to: rect)!

            // Create a new image based on the imageRef and rotate back to the original orientation
            let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

            return image
        }
    
    
}
