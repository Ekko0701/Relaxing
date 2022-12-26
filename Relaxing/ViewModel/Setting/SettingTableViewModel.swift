//
//  SettingViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/25.
//

import Foundation
import RxSwift
import RxRelay

protocol SettingTableViewModelType {
    // INPUT
    // ---------------------
    
    // OUTPUT
    // ---------------------
    var dataSource: [SettingSection] { get }
    var headerDataSource: [SettingSectionHeader] { get }
}

class SettingTableViewModel: SettingTableViewModelType {
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    
    // OUTPUT
    // ---------------------
    var dataSource: [SettingSection]
    var headerDataSource: [SettingSectionHeader]
    
    // MARK: - Initializer
    init() {
        // 라이선스 헤더 셀
        let licenseHeaderModel = licenseHeaderModel(title: "License")
        
        // 라이센스 셀 모델
        let licensesModel = [
            licenseCellModel(title: "Sound Licenses" ),
            //licenseCellModel(title: "Licenses")
        ]
        
        let licenseSectionHeader = SettingSectionHeader.license(licenseHeaderModel)
        
        let licenseSection = SettingSection.license(licensesModel)
        
        headerDataSource = [licenseSectionHeader]
        
        dataSource = [licenseSection]
    }
}
