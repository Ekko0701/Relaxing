//
//  ViewSetting.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/25.
//

import Foundation


enum SettingSection {
    case license([licenseCellModel])
}

/**
 Setting Cell에 보여질 내용
 */
struct licenseCellModel {
    let title: String?
}

// MARK: - Header
enum SettingSectionHeader {
    case license(licenseHeaderModel)
}

struct licenseHeaderModel {
    let title: String?
}
