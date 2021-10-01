//
//  SpinnerExtension.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 8/12/20.
//  Copyright © 2020 Paholo Inc. All rights reserved.
//

import UIKit


var vSpinner : UIView?
 
extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        
        /*
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        */
        
        let imageWidth = 150.0
        let imageHeight = 150.0
        
        let spinnerHeight = spinnerView.frame.size.height
        let spinnerWidth = spinnerView.frame.size.width
        
        print (spinnerWidth)
        print (spinnerHeight)
        
        let y = (Double(spinnerHeight) - Double(imageHeight)) / 2
        print(y)
        
        let x = (Double(spinnerWidth) - Double(imageWidth)) / 2
        print(x)
       
        let spinBox = UIImageView(frame: CGRect(x: x, y: y, width: imageWidth, height: imageHeight))
        spinBox.image = UIImage(named:  "romational-icon-v4.png")
       
        //spinBox.image = UIImage.gifImageWithName("RomHeart-No-Motion-Blur.gif")

         
        /*
         let rotationDuration: TimeInterval = 10
         
         UIView.animateKeyframes(withDuration: rotationDuration, delay: 0, options: [], animations: {
             UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: rotationDuration) {
                 spinBox.transform = CGAffineTransform(rotationAngle: .pi)
             }

         })
         
        */
        
        /*
        var transform = spinBox.transform
        transform = CGAffineTransform.identity
        UIView.animate(withDuration: 2, delay: 1, options: [], animations: {
            spinBox.transform = transform
        }, completion: nil)
        */
        
        /*
        UIView.animate(withDuration: 100, animations: {
            spinBox.transform = spinBox.transform.rotated(by: CGFloat(Double.pi) )
        })
        */
     
        //spinBox.startSpinning()
        
        DispatchQueue.main.async {
            //spinnerView.addSubview(ai)
            
            spinnerView.addSubview(spinBox)
            onView.addSubview(spinnerView)
            
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}


// spin an image
public extension UIImageView {
    func startSpinning() {
        
        
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    
    /*
        let animationKey = "rotation"
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.1
        rotation.repeatCount = Float.infinity
        
        self.layer.add(rotation, forKey: animationKey)
        */
        
        /*
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 0.7
        rotation.repeatCount = duration
        layer.add(rotation, forKey: "spin")*/
        
    }

    func stopSpinning() {
        layer.removeAllAnimations()
    }
}

