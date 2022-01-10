//
//  extensions.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 5/6/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation
import UIKit

// date age
extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}

// contains letters and numbers
extension String {
   var isAlphanumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
   }

    func matches(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive])
        return regex.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: 0, length: utf16.count)) != nil
    }

    func isValidURL() -> Bool {
        guard let url = URL(string: self) else { return false }
        if !UIApplication.shared.canOpenURL(url) {
            return false
        }

        let urlPattern = "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"
        return self.matches(pattern: urlPattern)
    }
}



// for neomorh shadows
extension UIView {

    func addBkgdShadowToView(color: UIColor, offsetX: Int, offsetY: Int, opacity: Int, shadowSize: Int) {

        self.layer.masksToBounds = false
        
        // Shadow properties

        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(CGFloat(opacity / 100))
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.layer.shadowRadius = CGFloat(shadowSize)
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        print ("im here but nothing")
    }

    func addInnerShadowToView(color: UIColor, offsetX: Int, offsetY: Int, shadowSize: Int) {
        
        let innerShadow = CALayer()
        innerShadow.frame = self.bounds
        
        // Shadow path (1pt ring around bounds)
        let radius = innerShadow.frame.size.height/2
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy:-2), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = color.cgColor
        innerShadow.shadowOffset = CGSize(width: offsetX, height: offsetY)
        innerShadow.shadowOpacity = 1.0
        innerShadow.shadowRadius = CGFloat(shadowSize)
        innerShadow.cornerRadius = innerShadow.frame.size.height/2
        
        self.layer.addSublayer(innerShadow)
        
    }
    

    func applyViewGradient(colors: [CGColor], radius: Int, direction: String)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        
        if direction == "horizontal" {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        }
        else if direction == "vertical" {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        else if direction == "angled-22" {
            gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.25)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            
        }
        else if direction == "angled-45" {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        }
        else {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }
        
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = CGFloat(radius)
        
        gradientLayer.locations = [0.20, 0.40, 0.70]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //how to use
    // self.button.applyViewGradient(colors: [UIColor.green.cgColor, UIColor.black.cgColor])
    
    func setBackgroundImage(imageName: String, buffer: Int ){
        let background = UIImage(named: imageName)

        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        var imageView : UIImageView!
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: buffer, height: Int(height)))
        
        imageView.contentMode =  UIView.ContentMode.scaleToFill
        
        imageView.clipsToBounds = false
        imageView.image = background
        imageView.center = center
        
        addSubview(imageView)
        sendSubviewToBack(imageView)
    }
    
    func setDropShadow(height: Int, opacity: Int, color: UIColor) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(opacity / 100)
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = CGFloat(height)
    }
    
    enum AnimationKeyPath: String {
        case opacity = "opacity"
    }

    func flash(animation: AnimationKeyPath ,withDuration duration: TimeInterval = 0.2, repeatCount: Float = 5){
        let flash = CABasicAnimation(keyPath: animation.rawValue)
        flash.duration = duration
        flash.fromValue = 1 // alpha
        flash.toValue = 0 // alpha
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = repeatCount

        layer.add(flash, forKey: nil)
    }
    
}

// for global fonts
extension UILabel {

    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
    
    
    /*
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    */
    
}


extension UIButton
{
    
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //how to use
    // self.button.applyGradient(colors: [UIColor.green.cgColor, UIColor.black.cgColor])

    func addBkgdShadowToButton(color: UIColor, offsetX: Int, offsetY: Int, opacity: Int, shadowSize: Int) {

        self.layer.masksToBounds = false
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = Float(CGFloat(opacity / 100))
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.layer.shadowRadius = CGFloat(shadowSize)
        print ("im here but nothing")
    }
    
    func addInnerShadowToButton(color: UIColor, offsetX: Int, offsetY: Int, shadowSize: Int) {
        
        let innerShadow = CALayer()
        innerShadow.frame = self.bounds
        
        // Shadow path (1pt ring around bounds)
        let radius = innerShadow.frame.size.height/2
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy:-2), cornerRadius:radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        
        // Shadow properties
        innerShadow.shadowColor = color.cgColor
        innerShadow.shadowOffset = CGSize(width: offsetX, height: offsetY)
        innerShadow.shadowOpacity = 1.0
        innerShadow.shadowRadius = CGFloat(shadowSize)
        innerShadow.cornerRadius = innerShadow.frame.size.height/2
        
        self.layer.addSublayer(innerShadow)
    }

}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func addBottomBorder(height: Int, color: UIColor) {
        
        let border = CALayer()
        
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.height - CGFloat(height), width: self.frame.width, height: CGFloat(height))
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}


extension UITextView {
    
    func centerVertically() {
            let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let size = sizeThatFits(fittingSize)
            let topOffset = (bounds.size.height - size.height * zoomScale) / 2
            let positiveTopOffset = max(1, topOffset)
            contentOffset.y = -positiveTopOffset
    }
    // use: textView.centerVertically()  in layout subviews??
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
            case UIRectEdge.top:
             border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: thickness)

            case UIRectEdge.bottom:
             border.frame = CGRect(x: 0, y: self.bounds.height - thickness,  width: self.bounds.width, height: thickness)

            case UIRectEdge.left:
             border.frame = CGRect(x: 0, y: 0,  width: thickness, height: self.bounds.height)

            case UIRectEdge.right:
             border.frame = CGRect(x: self.bounds.width - thickness, y: 0,  width: thickness, height: self.bounds.height)

            default:
             break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
// usage : let newURL = URL(string: "http://mysite3994.com?test1=blah&test2=blahblah")!
// usage : newURL.valueOf("test1") // Output i.e "blah"

extension UIImageView {
    
    func addBkgdShadowToImage(color: UIColor, offsetX: Int, offsetY: Int, opacity: Int, shadowSize: Int) {
        
        self.layer.masksToBounds = false
        
        // Shadow properties
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowRadius = CGFloat(shadowSize)
    }
    
}

extension UIScrollView {
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    //myScrollView.scrollToTop()
    
}



// usage: labelName.layer.addBorder(edge: UIRectEdge.right, color: UIColor.black, thickness: 1.5)



//-- end of extensions -- //


//- custom classes -- //

// my custom tap gesture with variables
class CustomTapGesture: UITapGestureRecognizer {
    var var1 = String()
    var var2 = Int()
}


class GradientLabel: UILabel {
    var gradientColors: [CGColor] = []

    override func drawText(in rect: CGRect) {
        if let gradientColor = drawGradientColor(in: rect, colors: gradientColors) {
            self.textColor = gradientColor
        }
        super.drawText(in: rect)
    }

    private func drawGradientColor(in rect: CGRect, colors: [CGColor]) -> UIColor? {
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        defer { currentContext?.restoreGState() }

        let size = rect.size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else { return nil }

        let context = UIGraphicsGetCurrentContext()
        context?.drawLinearGradient(gradient,
                                    start: CGPoint.zero,
                                    end: CGPoint(x: size.width, y: 0),
                                    options: [])
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = gradientImage else { return nil }
        return UIColor(patternImage: image)
    }
}

// usage:  label.gradientColors = [UIColor.blue.cgColor, UIColor.red.cgColor]





//@IBDesignable
class GradientSlider: UISlider {

    @IBInspectable var thickness: CGFloat = 10 {
        didSet {
            setup()
        }
    }

    @IBInspectable var sliderThumbImage: UIImage? {
        didSet {
            setup()
        }
    }

    func setup() {
        let minTrackStartColor = romTeal
        let minTrackEndColor = romOrange
        let maxTrackColor = romPink
        do {
            self.setMinimumTrackImage(try self.gradientImage(
            size: self.trackRect(forBounds: self.bounds).size,
            colorSet: [minTrackStartColor.cgColor, minTrackEndColor.cgColor]),
                                  for: .normal)
            self.setMaximumTrackImage(try self.gradientImage(
            size: self.trackRect(forBounds: self.bounds).size,
            colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
                                  for: .normal)
            self.setThumbImage(sliderThumbImage, for: .normal)
        } catch {
            self.minimumTrackTintColor = minTrackStartColor
            self.maximumTrackTintColor = maxTrackColor
        }
    }

    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =

    UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
        UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }


}
