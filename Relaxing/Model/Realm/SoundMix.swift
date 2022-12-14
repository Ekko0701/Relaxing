//
//  SoundMix.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/14.
//

import Foundation
import RealmSwift

/**
    Realm 데이터 저장에 사용될 데이터 구조
 */
class SoundMixs: Object {
    @Persisted var mixTitle: String = ""
    @Persisted var soundMixs = List<SoundMix>()
}

class SoundMix: Object {
    @Persisted var title: String = ""
    @Persisted var volume: Float = 1.0
    
    convenience init(title: String, volume: Float) {
        self.init()
        self.title = title
        self.volume = volume
    }
}



