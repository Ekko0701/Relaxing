//
//  LicenseViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/26.
//

import Foundation
import RxSwift
import RxRelay

protocol LicenseWebViewModelType {
    // INPUT
    // ---------------------
    var httpAddress: String { get }
    
    // OUTPUT
    // ---------------------
}

class LicenseWebViewModel: LicenseWebViewModelType {
    
    
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var httpAddress: String
    
    // OUTPUT
    // ---------------------
    
    init( httpAddress: String = String() ) {
        self.httpAddress = httpAddress
    }
}
