//
//  LicenseAddress.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/26.
//

import Foundation

/** 라이센스 http 주소 */
enum LicenseWebAddress {
    case sound
    case library
    
    var httpsAddress: String {
        switch self {
        case .sound:
            return "https://detailed-leo-c43.notion.site/License-18fa1ed5259b416cb3d812f279cd73f8"
        case .library:
            return "https://detailed-leo-c43.notion.site/abdffd8112304b06ab9880d10ce43448"
        }
    }
}
