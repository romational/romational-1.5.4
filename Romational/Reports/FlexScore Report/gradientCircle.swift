//
//  gradientCircle.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 6/3/21.
//  Copyright © 2021 Paholo Inc. All rights reserved.
//

import Foundation
import UIKit

class GradientCircleView: UIView {
    override func draw(_ rect: CGRect) {
        let thickness: CGFloat = 20
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - thickness / 2
        var last: CGFloat = 0
        for a in 1...360 {
            let ang = CGFloat(a) / 180 * .pi
            let arc = UIBezierPath(arcCenter: center, radius: radius, startAngle: last, endAngle: ang, clockwise: true)
            arc.lineWidth = thickness
            last = ang
            UIColor(hue: CGFloat(a) / 360, saturation: 1, brightness: 1, alpha: 1).set()
            arc.stroke()
        }
    }
}

//let radial = GradientCircleView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

//radial.backgroundColor = UIColor(red: 0.98, green: 0.92, blue: 0.84, alpha: 1) // "antique white"
