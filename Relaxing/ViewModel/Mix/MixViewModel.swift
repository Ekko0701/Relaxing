//
//  MixViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/14.
//

import Foundation
import RxSwift
import RxRelay
import RealmSwift

protocol MixViewModelType {
    // INPUT
    // ---------------------
    var mixTouch: PublishSubject<IndexPath> { get }
    var deleteMix: PublishSubject<IndexPath> { get }
    
    // OUTPUT
    // ---------------------
    var mixItems: [ViewMix] { get set }
}

class MixViewModel: MixViewModelType {
    let disposeBag = DisposeBag()
    
    // INPUT
    // ---------------------
    var mixTouch: PublishSubject<IndexPath>
    var deleteMix: PublishSubject<IndexPath>
    
    // OUTPUT
    // ---------------------
    var mixItems: [ViewMix]
    
    init() {
        let mixTouching = PublishSubject<IndexPath>()
        let deletingMix = PublishSubject<IndexPath>()
        
        // INPUT
        // ---------------------
        mixTouch = mixTouching.asObserver()
        deleteMix = deletingMix.asObserver()
        
        // OUTPUT
        // ---------------------
        
        let realm = try! Realm()
        let soundMixs = realm.objects(SoundMixs.self)
        
        mixItems = soundMixs.map { soundMixs in ViewMix(soundMixs) } // Cell의 (ViewMix) Title, Subtitle 설정
        
        mixTouching.bind { indexPath in
            let mixData = soundMixs[indexPath.row].soundMixs
            
            // 기존의 재생 목록 초기화
            SoundManager.shared.audioPlayers.removeAll()
            
            mixData.forEach { soundMix in
                switch soundMix.title {
                case "BirdSound":
                    SoundManager.shared.play(sound: BirdSound(volumeSize: soundMix.volume))
                case "HighWaySound":
                    SoundManager.shared.play(sound: HighWaySound(volumeSize: soundMix.volume))
                case "WaterSound":
                    SoundManager.shared.play(sound: WaterSound(volumeSize: soundMix.volume))
                case "Down Tempo":
                    SoundManager.shared.play(sound: DownTempo(volumeSize: soundMix.volume))
                case "Bonfire":
                    SoundManager.shared.play(sound: Bonfire(volumeSize: soundMix.volume))
                case "Rain 1":
                    SoundManager.shared.play(sound: Rain1(volumeSize: soundMix.volume))
                case "Rain 2":
                    SoundManager.shared.play(sound: Rain2(volumeSize: soundMix.volume))
                case "River":
                    SoundManager.shared.play(sound: River(volumeSize: soundMix.volume))
                case "Waterfall":
                    SoundManager.shared.play(sound: Waterfall(volumeSize: soundMix.volume))
                case "Forest":
                    SoundManager.shared.play(sound: Forest(volumeSize: soundMix.volume))
                case "Wave 1":
                    SoundManager.shared.play(sound: Wave1(volumeSize: soundMix.volume))
                case "Wave 2":
                    SoundManager.shared.play(sound: Wave2(volumeSize: soundMix.volume))
                case "Wind 1":
                    SoundManager.shared.play(sound: Wind1(volumeSize: soundMix.volume))
                case "Wind 2":
                    SoundManager.shared.play(sound: Wind2(volumeSize: soundMix.volume))
                case "Cave":
                    SoundManager.shared.play(sound: Cave(volumeSize: soundMix.volume))
                case "Bird":
                    SoundManager.shared.play(sound: Bird(volumeSize: soundMix.volume))
                case "Criket Crying":
                    SoundManager.shared.play(sound: CriketCrying(volumeSize: soundMix.volume))
                case "Cicada":
                    SoundManager.shared.play(sound: Cicada(volumeSize: soundMix.volume))
                case "Library":
                    SoundManager.shared.play(sound: Library(volumeSize: soundMix.volume))
                case "Temple":
                    SoundManager.shared.play(sound: Temple(volumeSize: soundMix.volume))
                case "Highway":
                    SoundManager.shared.play(sound: Highway(volumeSize: soundMix.volume))
                case "Firework":
                    SoundManager.shared.play(sound: Firework(volumeSize: soundMix.volume))
                case "Clock":
                    SoundManager.shared.play(sound: Clock(volumeSize: soundMix.volume))
                case "Pencil":
                    SoundManager.shared.play(sound: Pencil(volumeSize: soundMix.volume))
                case "Fan":
                    SoundManager.shared.play(sound: Fan(volumeSize: soundMix.volume))
                    
                default:
                    return
                }
            }
        }.disposed(by: disposeBag)
        
        deletingMix.bind { [weak self] indexPath in
            print("\(indexPath.item) 삭제")
            let rest = realm.objects(SoundMixs.self)[indexPath.row]
            try! realm.write {
                realm.delete(rest)
            }
            self?.mixItems.remove(at: indexPath.item)
        }.disposed(by: disposeBag)
        
        
    }
}

// MARK: - Realm
extension MixViewModel {
    private func readSoundMixs() -> Results<SoundMixs> {
        let realm = try! Realm()
        let soundMixs = realm.objects(SoundMixs.self)
        
        return soundMixs
    }
}
