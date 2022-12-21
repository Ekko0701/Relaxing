//
//  UIPreview+Ext.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/21.
//

import Foundation
#if DEBUG
import SwiftUI

extension UIView {
    private struct ViewRepresentable: UIViewRepresentable {
        let uiview: UIView
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            
        }
        
        func makeUIView(context: Context) -> some UIView {
            return uiview
        }
    }
    
    func getPreview() -> some View {
        ViewRepresentable(uiview: self)
    }
}

extension UIViewController {
    private struct VCRepresentable: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }
    
    func getPreview() -> some View {
        VCRepresentable(viewController: self)
    }
}

#endif


