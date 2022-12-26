//
//  ViewMix.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/15.
//

import Foundation

/**
 MixViewController에서 보여질 내용
 */
struct ViewMix {
    let mixTitle: String
    var subTitle: String
    
    init(_ item: SoundMixs) {
        mixTitle = item.mixTitle
        subTitle = ""
        item.soundMixs.forEach { soundMix in
            subTitle.append("\(soundMix.title.localized()), ")
        }
        
        subTitle.removeLast()
        subTitle.removeLast()
        
    }
}
