//
//  SoundMixViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/12.
//

import Foundation
import RxSwift
import RxRelay


protocol SoundMixViewModelType {
    // INPUT
    // ---------------------
    /** volumeSlider 값이 변할 때마다 volumeData를 전달받는다.
     volumeData는 cell의 indexPath와 그 cell의 slider 값으로 구성되었다.*/
    var volumeChange: PublishSubject<VolumeData> { get }

    
    // OUTPUT
    // ---------------------
    /** 현재 재생중인 플레이어 목록(Cell) 배열*/
    var playerItems: [ViewSoundMix] { get }

}

class SoundMixViewModel: SoundMixViewModelType {
    
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var volumeChange: PublishSubject<VolumeData>
    
    // OUTPUT
    // ---------------------
    var playerItems: [ViewSoundMix]
    
    init() {
        /** 현재 재생중인 목록 Sound Mix View의 Table Data 배열 */
        playerItems = []
        
        /** Volume Slider Value Change Event */
        let volumeChanging = PublishSubject<VolumeData>()
        
        // INPUT
        // ---------------------
        volumeChange = volumeChanging.asObserver()
        
        // OUTPUT
        // ---------------------
        SoundManager.shared.audioPlayers.forEach { title, player in
            playerItems.append(ViewSoundMix(title: title, playerVolume: player.volume))
        }
        
        volumeChanging.bind { [weak self] volumeDate in
            guard let playerTitle = self?.playerItems[volumeDate.itemNumber.item].title else { return }
            guard let player = SoundManager.shared.audioPlayers[playerTitle] else { return }
            SoundManager.shared.changeVolume(player: player, size: volumeDate.volumeValue / 100 )
        }.disposed(by: disposeBag)
    }
}
