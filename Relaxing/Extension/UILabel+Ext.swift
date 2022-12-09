//
//  UILabel+Ext.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit

extension UILabel {
    
    /**
     Label의 Text에 Poppins 폰트 적용
     */
    func applyPoppins (
        text: String = "",
        style: PoppinsStyle = .regular,
        size: CGFloat = 11.0,
        color: UIColor = .black )
    {
        self.text = text
        self.font = font.setPoppinsStyle(style: style, size: size)
        self.textColor = color
    }
}
