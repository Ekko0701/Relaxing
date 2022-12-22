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
    /** Start Button Touch Event */
    var startButtonTouch: AnyObserver<Double> { get }
    /** Exit Button Touch Event */
    var exitButtonTouch: AnyObserver<Void> { get }
    /** Behind View Touch Event */
    var behindViewTouch: AnyObserver<Void> { get }
    
    // OUTPUT
    // ---------------------
    /** Timer PopUp에서 나가는 event를 처리하는 subject */
    var dismissTimerView: PublishSubject<Void> { get }
    /** Timer Activate */
    var timerActivated: Observable<Bool> { get }
}

class TimerPopUpViewModel: TimerPopUpViewModelType {
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var startButtonTouch: AnyObserver<Double>
    var exitButtonTouch: AnyObserver<Void>
    var behindViewTouch: AnyObserver<Void>
    
    // OUTPUT
    // ---------------------
    var dismissTimerView: PublishSubject<Void>
    var timerActivated: Observable<Bool>
    
    init() {
        let startButtonTouching = PublishSubject<Double>()
        let exitButtonTouching = PublishSubject<Void>()
        let behindViewTouching = PublishSubject<Void>()
        
        let dismissingTimerView = PublishSubject<Void>()
        
        let timerActivating = BehaviorSubject(value: false)
        
        // INPUT
        // ---------------------
        startButtonTouch = startButtonTouching.asObserver()
        exitButtonTouch = exitButtonTouching.asObserver()
        behindViewTouch = behindViewTouching.asObserver()
        
        timerActivated = timerActivating.distinctUntilChanged()
        
        // OUTPUT
        // ---------------------
        dismissTimerView = dismissingTimerView.asObserver()
        
        startButtonTouching
            .do(onNext: { _ in timerActivating.onNext(true) })
            .bind { timerDuration in
                TimerManager.shared.timerDuration = timerDuration
                TimerManager.shared.start(withPeriod: timerDuration)
            }.disposed(by: disposeBag)
        
        behindViewTouching
            .bind(onNext: { _ in
                dismissingTimerView.onNext(Void())
            }).disposed(by: disposeBag)
        
        exitButtonTouching
            .bind(onNext: { _ in
                dismissingTimerView.onNext(Void())
            }).disposed(by: disposeBag)
        
        /** TimerManager의 testOn을 구독해 값을 timerActivating에 보낸다. */
        TimerManager.shared.testOn.subscribe(onNext: { value in
            timerActivating.onNext(value)
        }).disposed(by: disposeBag)
    
        
    }
}
