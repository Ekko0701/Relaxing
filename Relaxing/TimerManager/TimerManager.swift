//
//  TimerManager.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/19.
//

import Foundation

class TimerManager {
    static let shared = TimerManager()
    
    var timer = Timer()
    var timerDuration: Double = 0.0
    
    func start(withPeriod period: TimeInterval) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
    }
    
    @objc
    func timerCallBack() {
        print(timerDuration)
        if !(timerDuration > 0) {
            SoundManager.shared.audioPlayers.forEach { title, player in
                player.stop()
            }
            timer.invalidate()
        } else {
            timerDuration = timerDuration - 1
        }
        
    }
    
}
