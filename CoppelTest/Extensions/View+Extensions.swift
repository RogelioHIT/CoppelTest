//
//  View+Extensions.swift
//  CoppelTest
//
//  Created by Rogelio on 07/07/22.
//

import UIKit

extension UIView {
    
    func addRoundedCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setGradientBackground(from color1:UIColor, to color2: UIColor) {
        let colorTop =  color1.cgColor
        let colorBottom = color2.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom, colorTop]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
