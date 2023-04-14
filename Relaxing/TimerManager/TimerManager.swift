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
    
    var isTimerInProgress = false
    
    var timerInProgress = PublishSubject<Void>()
    var timerFinished = PublishSubject<Void>()
    var timerCancel = PublishSubject<Bool>()
    var timeObservable = PublishSubject<String>()
    
    func start(withPeriod period: TimeInterval) {
        timer.invalidate()
        timeObservable.onNext(secondToString(second: timerDuration))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
        timerInProgress.onNext(Void()) // 이벤트 방출
        
        isTimerInProgress = true
    }
    
    func stop() {
        timer.invalidate()
        timerCancel.onNext(true)
        
        isTimerInProgress = false
    }
    
    @objc
    func timerCallBack() {
        print(timerDuration)
        if !(timerDuration > 0) {
            SoundManager.shared.audioPlayers.forEach { title, player in
                player.stop()
            }
            timer.invalidate()
            timerFinished.onNext(Void())
            isTimerInProgress = false
        } else {
            timeObservable.onNext(secondToString(second: timerDuration))
            timerDuration = timerDuration - 1
            timerInProgress.onNext(Void())
        }
        
    }
    
    func secondToString(second: Double) -> String {
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
    //.
}
