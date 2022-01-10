//
//  GaugeView.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/2/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//  // https://www.hackingwithswift.com/articles/150/how-to-create-a-custom-gauge-control-using-uikit
//

import UIKit

class GaugeView: UIView {

    let yellow  =   UIColor(red:0.98, green:0.74, blue:0.24, alpha:1.0)
    let green   =   UIColor(red:0.13, green:0.77, blue:0.54, alpha:1.0)
    let teal    =   UIColor(red:0.15, green:0.72, blue:0.83, alpha:1.0)
    let navy    =   UIColor(red:0.01, green:0.31, blue:0.43, alpha:1.0)
    let purple  =   UIColor(red:0.65, green:0.31, blue:0.62, alpha:1.0)
    let black   =   UIColor(red:0, green:0, blue:0, alpha:1.0)
    let clearColor = UIColor(red:0, green:0, blue:0, alpha:0.0)
    
    lazy var outerBezelColor = clearColor
    var outerBezelWidth: CGFloat = 20
    
    var innerBezelColor = romBkgd
    var innerBezelWidth: CGFloat = 2
    
    var insideColor = UIColor.clear
    
    func drawBackground(in rect: CGRect, context ctx: CGContext) {
        // draw the outer bezel as the largest circle
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [romTeal, green, yellow, romOrange, romPink]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        //gradientLayer.set()
        outerBezelColor.set()
        ctx.fillEllipse(in: rect)
        
        // move in a little on each edge, then draw the inner bezel
        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        innerBezelColor.set()
        ctx.fillEllipse(in: innerBezelRect)
        
        
    
        // finally, move in some more and draw the inside of our gauge
        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        insideColor.set()
        ctx.fillEllipse(in: insideRect)
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        drawBackground(in: rect, context: ctx)
        
        drawSegments(in: rect, context: ctx)
        //drawTicks(in: rect, context: ctx)
        
        //drawCenterDisc(in: rect, context: ctx)
        
    }
    
    var segmentWidth: CGFloat = 10
    
    lazy var segmentColors = [romTeal, green, yellow, romOrange, romPink]
    lazy var segmentAngles = [Int]()

    var start: CGFloat = 0.0
    var totalAngle: CGFloat = 270
    var rotation: CGFloat = -135
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    func drawSegments(in rect: CGRect, context ctx: CGContext) {
        
        //setup the angles using ranges
        for i in 0..<Ranges.count {
            
            let thisRange = Ranges[i] as? NSDictionary
            
            //print (thisRange!["low"]!)
          
            let lowRange  = Int((thisRange!["low"] as? String)!)!
            let highRange = Int((thisRange!["high"] as? String)!)!
        
            // if 20 pts then this is 55
            let thisAngle = Int(Double(highRange - lowRange) * 2.75)
        
            segmentAngles.append(thisAngle)
        }
        
        // 1: Save the current drawing configuration
        ctx.saveGState()
        
        // 2: Move to the center of our drawing rectangle and rotate so that we're pointing at the start of the first segment
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
        
        // 3: Set up the user's line width
        ctx.setLineWidth(segmentWidth)
        
        // 4: Calculate the size of each segment in the total gauge
        //let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))
        
        // 5: Calculate how wide the segment arcs should be
        let segmentRadius = (((rect.width - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth
        
        // 6: Draw each segment
        for (index, segment) in segmentColors.enumerated() {
            
            // use dynamic segment angle
            let segmentAngle = deg2rad(CGFloat(segmentAngles[index]))
            //print (segmentAngle)
            
            // figure out where the segment starts in our arc
            //let start = CGFloat(index) * segmentAngle
            
            // activate its color
            segment.set()
            
            // add a path for the segment
            ctx.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + segmentAngle, clockwise: false)
            
            // and stroke it using the activated color
            ctx.drawPath(using: .stroke)
            
            // run this after to start at 0 for first segment (vs using index at 0)
            start = start + segmentAngle
            //print (start)
            
        }
        
        // 7: Reset the graphics state
        ctx.restoreGState()
    }
    
   
    var majorTickColor = UIColor.black
    var majorTickWidth: CGFloat = 2
    var majorTickLength: CGFloat = 25
    
    var minorTickColor = UIColor.black.withAlphaComponent(0.5)
    var minorTickWidth: CGFloat = 1
    var minorTickLength: CGFloat = 20
    var minorTickCount = 3
    
    
    func drawTicks(in rect: CGRect, context ctx: CGContext) {
        // save our clean graphics state
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
        
        let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))
        
        let segmentRadius = (((rect.width - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth
        
        // save the graphics state where we've moved to the center and rotated towards the start of the first segment
        ctx.saveGState()
        
        // draw major ticks
        ctx.setLineWidth(majorTickWidth)
        majorTickColor.set()
        
        let majorEnd = segmentRadius + (segmentWidth / 2)
        let majorStart = majorEnd - majorTickLength
        
        for _ in 0 ... segmentColors.count {
            ctx.move(to: CGPoint(x: majorStart, y: 0))
            ctx.addLine(to: CGPoint(x: majorEnd, y: 0))
            ctx.drawPath(using: .stroke)
            ctx.rotate(by: segmentAngle)
        }
        
        // go back to the state we had before we drew the major ticks
        ctx.restoreGState()
        
        // save it again, because we're about to draw the minor ticks
        ctx.saveGState()
        
        // draw minor ticks
        ctx.setLineWidth(minorTickWidth)
        minorTickColor.set()
        
        let minorEnd = segmentRadius + (segmentWidth / 2)
        let minorStart = minorEnd - minorTickLength
        
        let minorTickSize = segmentAngle / CGFloat(minorTickCount + 1)
        
        for _ in 0 ..< segmentColors.count {
            ctx.rotate(by: minorTickSize)
            
            for _ in 0 ..< minorTickCount {
                ctx.move(to: CGPoint(x: minorStart, y: 0))
                ctx.addLine(to: CGPoint(x: minorEnd, y: 0))
                ctx.drawPath(using: .stroke)
                ctx.rotate(by: minorTickSize)
            }
        }
        
        // go back to the graphics state where we've moved to the center and rotated towards the start of the first segment
        ctx.restoreGState()
        
        // go back to the original graphics state
        ctx.restoreGState()
    }
    
    
    var outerCenterDiscColor = UIColor(white: 0.7, alpha: 1)
    var outerCenterDiscWidth: CGFloat = 35
    var innerCenterDiscColor = UIColor.black
    var innerCenterDiscWidth: CGFloat = 25
    
    func drawCenterDisc(in rect: CGRect, context ctx: CGContext) {
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)
        
        let outerCenterRect = CGRect(x: -outerCenterDiscWidth / 2, y: -outerCenterDiscWidth / 2, width: outerCenterDiscWidth, height: outerCenterDiscWidth)
        outerCenterDiscColor.set()
        ctx.fillEllipse(in: outerCenterRect)
        
        let innerCenterRect = CGRect(x: -innerCenterDiscWidth / 2, y: -innerCenterDiscWidth / 2, width: innerCenterDiscWidth, height: innerCenterDiscWidth)
        innerCenterDiscColor.set()
        ctx.fillEllipse(in: innerCenterRect)
        ctx.restoreGState()
    }
    
    var needleColor = UIColor.black
    var needleWidth: CGFloat = 4
    let needle = UIView()

    
    let valueLabel = UILabel()
    var valueFont = UIFont.systemFont(ofSize: 56)
    var valueColor = UIColor.black
    
    func setUp() {
        needle.backgroundColor = needleColor
        needle.translatesAutoresizingMaskIntoConstraints = false
        
        // make the needle a third of our height
        needle.bounds = CGRect(x: 0, y: 0, width: needleWidth, height: bounds.height / 3.25)
        
        // align it so that it is positioned and rotated from the bottom center
        needle.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        // now center the needle over our center point
        needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
        addSubview(needle)
        
        valueLabel.font = valueFont
        valueLabel.text = "0"
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
            ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    var value: Int = 0 {
        didSet {
            // update the value label to show the exact number
            valueLabel.text = String(value)
            
            // figure out where the needle is, between 0 and 1
            let needlePosition = CGFloat(value) / 100
            
            // create a lerp from the start angle (rotation) through to the end angle (rotation + totalAngle)
            let lerpFrom = rotation
            let lerpTo = rotation + totalAngle
            
            // lerp from the start to the end position, based on the needle's position
            let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
            needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
        }
    }
    
}
