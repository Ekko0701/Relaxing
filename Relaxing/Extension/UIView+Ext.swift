//
//  UIView+Ext.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/20.
//

import Foundation
import UIKit

extension UIView {
    func setGradient(firstColor: UIColor, secondColor: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
