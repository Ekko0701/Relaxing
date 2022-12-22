//
//  TimerManager.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/19.
//

import Foundation
import RxSwift

class TimerManager {
    static let shared = TimerManager()
    
    var timer = Timer()
    var timerDuration: Double = 0.0
    var isOn = false
    var disposeBag = DisposeBag()
    
    var testOn = BehaviorSubject(value: false)
    
    func start(withPeriod period: TimeInterval) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        //isOn = true
        testOn.onNext(true) // 이벤트 방출
    }
    
    func stop() {
        print("멈춤")
        timer.invalidate()
        //isOn = false
        testOn.onNext(false)
    }
    
    @objc
    func timerCallBack() {
        print(timerDuration)
        if !(timerDuration > 0) {
            SoundManager.shared.audioPlayers.forEach { title, player in
                player.stop()
            }
            timer.invalidate()
            testOn.onNext(false)
        } else {
            timerDuration = timerDuration - 20
            testOn.onNext(true)
        }
        
    }
    
}
