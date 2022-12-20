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

//enum playMixSound: String, Sound {
//    func getTitle() -> String {
//        <#code#>
//    }
//
//    func getFileName() -> String {
//        <#code#>
//    }
//
//    func getFileExtension() -> String {
//        <#code#>
//    }
//
//    var tag: Int
//
//    var soundTitle: String
//
//    var volumeSize: Float
//
//    case BirdSound
//    case HighWaySound
//    case WaterSound
//
//    var soundData: Sound {
//        switch self {
//        case .BirdSound:
//            return playMixSound.BirdSound
//        }
//    }
//}
