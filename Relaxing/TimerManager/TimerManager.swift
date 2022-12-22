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
    var disposeBag = DisposeBag()
    
    var testOn = BehaviorSubject(value: false)
    var timeObservable = PublishSubject<String>()
    
    func start(withPeriod period: TimeInterval) {
        timer.invalidate()
        timeObservable.onNext(secondToString(second: timerDuration))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        testOn.onNext(true) // 이벤트 방출
    }
    
    func stop() {
        timer.invalidate()
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
            timeObservable.onNext(secondToString(second: timerDuration))
            timerDuration = timerDuration - 1
            testOn.onNext(true)
        }
        
    }
    
    private func secondToString(second: Double) -> String {
        var hour = String(Int(timerDuration / 3600))
        var minute = String(Int( Int(timerDuration / 60) % 60 ))
        var second = String(Int(timerDuration) % 60)
        
        if hour.count < 2 {
            hour = "0" + hour
        }
        
        if minute.count < 2 {
            minute = "0" + minute
        }
        
        if second.count < 2 {
            second = "0" + second
        }
        
        let timeString: String = hour + ":" + minute + ":" + second
        
        return timeString
    }
    
}
