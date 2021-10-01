//
//  AGCollectionView.swift
//  Romational
//
//  Created by Nicholas Zen Paholo on 12/9/19.
//  Copyright © 2019 Paholo Inc. All rights reserved.
//

import Foundation
import UIKit

class AGCollectionView: UICollectionView {
    
    fileprivate var heightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.associateConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.associateConstraints()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if self.heightConstraint != nil {
            self.heightConstraint.constant = floor(self.contentSize.height)
        }
        else{
            self.sizeToFit()
            print("Set a heightConstraint set size to fit content")
        }
    }
    
    func associateConstraints() {
        // iterate through height constraints and identify
        
        for constraint: NSLayoutConstraint in constraints {
            if constraint.firstAttribute == .height {
                if constraint.relation == .equal {
                    heightConstraint = constraint
                }
            }
        }
    }
    
}

