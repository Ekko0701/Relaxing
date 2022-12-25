//
//  SoundMixViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/12.
//

import Foundation
import RxSwift
import RxRelay
import RealmSwift

protocol SoundMixViewModelType {
    // INPUT
    // ---------------------
    /** volumeSlider 값이 변할 때마다 volumeData를 전달받는다.
     volumeData는 cell의 indexPath와 그 cell의 slider 값으로 구성되었다.*/
    var volumeChange: PublishSubject<VolumeData> { get }
    
    /** mix 저장 버튼 터치 */
    var saveButtonTouch: PublishSubject<Void> { get }
    
    /** alert Ok 버튼 터치 */
    var alertOKTouch: PublishSubject<String> { get }
    
    // OUTPUT
    // ---------------------
    /** 현재 재생중인 플레이어 목록(Cell) 배열*/
    var playerItems: [ViewSoundMix] { get }
    
    /** 믹스 추가 알람창 */
    var showMixAlert: Observable<Void> { get }

}

class SoundMixViewModel: SoundMixViewModelType {
    
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var volumeChange: PublishSubject<VolumeData>
    var saveButtonTouch: PublishSubject<Void>
    var alertOKTouch: PublishSubject<String>
    
    // OUTPUT
    // ---------------------
    var playerItems: [ViewSoundMix]
    var showMixAlert: Observable<Void>
    
    // MARK: - Initializer
    init() {
        /** 현재 재생중인 목록 Sound Mix View의 Table Data 배열 */
        playerItems = []
        
        /** Volume Slider Value Change Event */
        let volumeChanging = PublishSubject<VolumeData>()
        /** Save Button Touch Event */
        let saveButtonTouching = PublishSubject<Void>()
        /** OK Button at Alert Touch Event */
        let alertOKTouching = PublishSubject<String>()
        
        let createNoMix = PublishSubject<Void>()
        
        // INPUT
        // ---------------------
        volumeChange = volumeChanging.asObserver()
        saveButtonTouch = saveButtonTouching.asObserver()
        alertOKTouch = alertOKTouching.asObserver()
        
        // OUTPUT
        // ---------------------
        //showMixAlert = saveButtonTouching.asObserver()
        //showMixAlert = saveButtonTouch.asObserver()
        if SoundManager.shared.audioPlayers.count > 0 {
            showMixAlert = saveButtonTouch.asObserver()
        } else {
            showMixAlert = createNoMix.asObserver()
        }
        
        
        SoundManager.shared.audioPlayers.forEach { title, player in
            playerItems.append(ViewSoundMix(title: title, playerVolume: player.volume))
        }
        
        // Volume Slider Modified
        volumeChanging.bind { [weak self] volumeDate in
            guard let playerTitle = self?.playerItems[volumeDate.itemNumber.item].title else { return }
            guard let player = SoundManager.shared.audioPlayers[playerTitle] else { return }
            SoundManager.shared.changeVolume(player: player, size: volumeDate.volumeValue / 100 )
        }.disposed(by: disposeBag)
        
        // Alert OK Touched
        alertOKTouching.bind { [weak self] mixTitle in
            self?.saveSoundMix(with: mixTitle)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }.disposed(by: disposeBag)
    }
}

// MARK: - Realm
extension SoundMixViewModel {
    /**
     사운드 믹스 저장하기
     */
    private func saveSoundMix(with mixTitle: String) {
        print("saveAtRealm")
        let realm = try! Realm()
        
        let soundMixs = SoundMixs()

        SoundManager.shared.audioPlayers.forEach { title, player in
            let soundMix = SoundMix(title: title, volume: player.volume)
            soundMixs.soundMixs.append(soundMix)
        }
        soundMixs.mixTitle = mixTitle
        
        try! realm.write {
            realm.add(soundMixs)
        }
    }
    
    
}
