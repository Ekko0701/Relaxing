//
//  SettingViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/26.
//

import Foundation
import RxSwift
import RxRelay

protocol SettingViewModelType {
    // INPUT
    // ---------------------
    /** 라이센스 탭 터치 */
    var cellTouch: AnyObserver<IndexPath> { get }
    
    // OUTPUT
    // ---------------------
    var showLicenseWebView: Observable<String> { get }
}

class SettingViewModel: SettingViewModelType {
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var cellTouch: AnyObserver<IndexPath>
    
    // OUTPUT
    // ---------------------
    var showLicenseWebView: Observable<String>
    
    // MARK: - Initializer
    init() {
        let cellTouching = PublishSubject<IndexPath>()
        
        // INPUT
        // ---------------------
        cellTouch = cellTouching.asObserver()
        
        // OUTPUT
        // ---------------------
        showLicenseWebView = cellTouching.asObservable()
            .filter{ $0.section == 0 }
            .map {
                switch $0.item {
                case 0:
                    return LicenseWebAddress.sound.httpsAddress
                default:
                    return LicenseWebAddress.library.httpsAddress
                }
            }
    }
}
