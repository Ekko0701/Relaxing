//
//  CALayer+Ext.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/20.
//

import Foundation
import UIKit

extension CALayer {
    /// Border 적용
    ///
    func applyBorder(
        width: CGFloat = 0.78,
        color: UIColor,
        radius: CGFloat?
    ) {
        borderWidth = width
        borderColor = color.cgColor
        if let radius = radius {
            cornerRadius = radius
        }
    }
    
    
}
