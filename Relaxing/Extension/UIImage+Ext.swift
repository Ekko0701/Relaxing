//
//  UIImage+Ext.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/21.
//

import Foundation
import UIKit

extension UIImage {
    func resizeTapBarItem() -> UIImage {
        let size = CGSize(width: 40, height: 40)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        return renderImage
    }
}
