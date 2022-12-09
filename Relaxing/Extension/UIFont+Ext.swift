//
//  UIFont+Ext.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit

/**
 Poppins
 ===> Poppins-Regular
 ===> Poppins-Thin
 ===> Poppins-ExtraLight
 ===> Poppins-Light
 ===> Poppins-Medium
 ===> Poppins-SemiBold
 ===> Poppins-Bold
 */

enum PoppinsStyle {
    case thin, extraLight, light, regular, medium, semiBold, bold
}

extension UIFont {
    
    /**
     Poppins 폰트 설정
     */
    func setPoppinsStyle(style: PoppinsStyle = .regular, size: CGFloat = 11) -> UIFont {
        var font = ""
        switch style {
        case .thin:
            font = "Poppins-Thin"
        case .extraLight:
            font = "Poppins-ExtraLight"
        case .light:
            font = "Poppins-Light"
        case .regular:
            font = "Poppins-Regular"
        case .medium:
            font = "Poppins-Medium"
        case .semiBold:
            font = "Poppins-SemiBold"
        case .bold:
            font = "Poppins-Bold"
        }
        
        return UIFont(name: font, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
