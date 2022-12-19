//
//  TimerPopUpViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/19.
//

import Foundation
import RxSwift
import RxRelay

protocol TimerPopUpViewModelType {
    // INPUT
    // ---------------------
    /** OK Button Touch Event */
    var startButtonTouch: AnyObserver<Double> { get }
    
    // OUTPUT
    // ---------------------
}

class TimerPopUpViewModel: TimerPopUpViewModelType {
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var startButtonTouch: AnyObserver<Double>
    
    // OUTPUT
    // ---------------------
    
    init() {
        let startButtonTouching = PublishSubject<Double>()
        
        // INPUT
        // ---------------------
        startButtonTouch = startButtonTouching.asObserver()
        
        // OUTPUT
        // ---------------------
        
        
        startButtonTouching
            .bind { timerDuration in
                TimerManager.shared.timerDuration = timerDuration
                TimerManager.shared.start(withPeriod: timerDuration)
            }.disposed(by: disposeBag)
    }
}
