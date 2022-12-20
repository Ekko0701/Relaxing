//
//  String.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/20.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
