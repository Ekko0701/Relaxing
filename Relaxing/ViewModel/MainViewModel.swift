//
//  MainViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

protocol MainViewModelType {
    // ---------------------
    // INPUT
    // ---------------------
    /** Sound Item (Cell) 터치 이벤트 PublishSubject */
    var soundTouch: PublishSubject<IndexPath> { get }
    
    /** Play Button 터치 이벤트 PublishSubject */
    var playButtonTouch: AnyObserver<Void> { get }

    
    // ---------------------
    // OUTPUT
    // ---------------------
    /** Sound Item (Cell) 배열 */
    var soundItems: [SoundItemModel] { get }
    
    /** Sound Data 음성 파일 데이터 배열*/
    var soundData: [Sound] { get }
    
    /** Control Bar에서 컨트롤 하는 전체 플레이 여부 Observable */
    var isEntirePlayed: Observable<Bool> { get }
}

class MainViewModel: MainViewModelType {
    
    let disposeBag = DisposeBag()
    
    // INPUT ----------------
    var soundTouch: PublishSubject<IndexPath>
    var playButtonTouch: AnyObserver<Void>
    
    // OUTPUT ---------------
    var soundItems: [SoundItemModel]
    let soundData: [Sound]
    var isEntirePlayed: Observable<Bool>
    
    init() {
        /** CollectionView의 Sound Item Touch Event */
        let soundToucing = PublishSubject<IndexPath>()
        
        /** Control Bar View Button Touch Event */
        let playButtonTouching = PublishSubject<Void>()
        
        /** Control Bar View로 전체 player를 컨트롤 하는 경우 버튼 이미지 변환을 위한 Relay */
        let isEntirePlaying = BehaviorRelay<Bool>(value: false)
        
        // INPUT
        soundTouch = soundToucing.asObserver()
        playButtonTouch = playButtonTouching.asObserver()
        
        // OUTPUT
        isEntirePlayed = isEntirePlaying.distinctUntilChanged()
        
        soundItems = [
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "새소리"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "고속도로 소리"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "1번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "2번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "1번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "2번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "1번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "2번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "3번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "4번"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "5번"),
        ]
        
        soundData = [
            BirdSound(),
            HighWaySound(),
            WaterSound(),
        ]
        
        // Touch Events
        // 1. Sound Item Touch
        soundToucing.do(onNext: { _ in
            //isEntirePlaying.accept(true)
        
        })
            .subscribe { [weak self] indexPath in
            guard let sound = self?.soundData[indexPath.item] else { return }
            SoundManager.shared.play(sound: sound)
                
                #warning("TODO : - test ")
                self?.soundItems[indexPath.item].isSelected.toggle()
        }.disposed(by: disposeBag)
        
        // 2. Play Button Touch
        playButtonTouching
            .do(onNext: { _ in
//                if SoundManager.shared.audioPlayers.isEmpty {
//                    isEntirePlaying.accept(false)
//                } else {
//                    isEntirePlaying.accept(SoundManager.shared.entirePlaying)
//                }
                #warning("TODO : - 필터를 이용해서 구현하는 방법도 생각해보자. ")
                var testIsPlaying = false
                _ = SoundManager.shared.audioPlayers.mapValues({ player in
                    if player.isPlaying {
                        testIsPlaying = true
                    }
                })
                if testIsPlaying {
                    isEntirePlaying.accept(true)
                } else {
                    isEntirePlaying.accept(false)
                }
            })
            .subscribe(onNext: { _ in
            SoundManager.shared.playAndPauseAll()
        }).disposed(by: disposeBag)
            
        
    }
}

/*
 soundToucing.subscribe { [weak self] indexPath in
     if indexPath.item == 5 {
         print("볼륨 체인지")
         let title = self?.soundData[0].getTitle()
         let player = SoundManager.shared.audioPlayers[title!]
         SoundManager.shared.changeVolume(player: player!, size: 0.5)
     } else {
         print("MainViewModel - soundTouching - \(indexPath)")
         guard let sound = self?.soundData[indexPath.item] else { return }
         SoundManager.shared.play(sound: sound)
     }
//            print("MainViewModel - soundTouching - \(indexPath)")
//            guard let sound = self?.soundData[indexPath.item] else { return }
//            SoundManager.shared.play(sound: sound)
     
 }.disposed(by: disposeBag)
 */
