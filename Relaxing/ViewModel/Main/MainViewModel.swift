//
//  MainViewModel.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import RxSwift
import RxRelay

protocol MainViewModelType {
    // INPUT
    // ---------------------
    /** Sound Item (Cell) 터치 이벤트 PublishSubject */
    var soundTouch: PublishSubject<IndexPath> { get }
    
    /** Play Button 터치 이벤트 Observer */
    var playButtonTouch: AnyObserver<Void> { get }
    /** Sound Mix Button 터치 이벤트 Observer*/
    var soundMixButtonTouch: AnyObserver<Void> { get }
    /** Timer Button 터치 이벤트 Observer */
    var timerButtonTouch: AnyObserver<Void> { get }
    
    var mainViewWillAppear: AnyObserver<Void> { get }
    
    // OUTPUT
    // ---------------------
    /** Sound Item (Cell) 배열 */
    var soundItems: [SoundItemModel] { get }
    
    /** Sound Data 음성 파일 데이터 배열*/
    var soundData: [Sound] { get }
    
    /** Control Bar에서 컨트롤 하는 전체 플레이 여부 Observable */
    var isEntirePlayed: Observable<Bool> { get }
    
    /** Sound Mix View Controller를 보임 */
    var showSoundMixVC: Observable<Void> { get }
    
    /** Timer PopUp View를 보임 */
    var showTimerPopUp: Observable<Void> { get }
    
    /** CollectionView Cell의 체크 여부를 확인후 reload해주기 위한 Observable */
    var reloadCollection: Observable<Void> { get }
}

class MainViewModel: MainViewModelType {
    
    let disposeBag = DisposeBag()
   
    // INPUT
    // ---------------------
    var soundTouch: PublishSubject<IndexPath>
    var playButtonTouch: AnyObserver<Void>
    var soundMixButtonTouch: AnyObserver<Void>
    var timerButtonTouch: AnyObserver<Void>
    
    var mainViewWillAppear: AnyObserver<Void>

    
    // OUTPUT
    // ---------------------
    var soundItems: [SoundItemModel]
    let soundData: [Sound]
    var isEntirePlayed: Observable<Bool>
    var showSoundMixVC: Observable<Void>
    var showTimerPopUp: Observable<Void>
    
    var reloadCollection: Observable<Void>
    
    init() {
        /** CollectionView의 Sound Item Touch Event */
        let soundToucing = PublishSubject<IndexPath>()
        
        /** Control Bar View Button Touch Event */
        let playButtonTouching = PublishSubject<Void>()
        /** Control Bar View Sound Mix Button Event */
        let soundMixButtonTouching = PublishSubject<Void>()
        /** Control Bar View Timer Button Event */
        let timerButtonTouching = PublishSubject<Void>()
        
        /** Control Bar View로 전체 player를 컨트롤 하는 경우 버튼 이미지 변환을 위한 Relay*/
        let isEntirePlaying = BehaviorRelay<Bool>(value: false)
        
        /** View Will Appear 하면 reloading하기 위한 Subject*/
        let reloading = PublishSubject<Void>()
        
        let reloadingCollection = PublishSubject<Void>()
        
        // INPUT
        // ---------------------
        soundTouch = soundToucing.asObserver()
        playButtonTouch = playButtonTouching.asObserver()
        soundMixButtonTouch = soundMixButtonTouching.asObserver()
        timerButtonTouch = timerButtonTouching.asObserver()
        
        mainViewWillAppear = reloading.asObserver()
        
        // OUTPUT
        // ---------------------
        isEntirePlayed = isEntirePlaying.distinctUntilChanged()
        showSoundMixVC = soundMixButtonTouching.asObserver() // soundMixButtonTouch -> SoundMixButtonTouching -> showSoundMixVC
        showTimerPopUp = timerButtonTouching.asObserver()
        reloadCollection = reloadingCollection.asObserver()
        
        soundItems = [
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "BirdSound"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "HighWaySound"),
            SoundItemModel(image: UIImage(systemName: "gear")!, title: "WaterSound"),
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
        
        // Sound Item Touch
        soundToucing
            .subscribe { [weak self] indexPath in
            guard let sound = self?.soundData[indexPath.item] else { return }
            SoundManager.shared.play(sound: sound)
            self?.playingState(observable: isEntirePlaying)         // Control Bar의 Play 버튼 활성화 여부 전달
            self?.soundItems[indexPath.item].isSelected.toggle()    // Cell 의 배경 색상 바꿔주는 코드 -> isSelected 속성을 바꿔 준다.
        }.disposed(by: disposeBag)
        
        // Play Button Touch
        playButtonTouching
            .subscribe(onNext: { [weak self] _ in
            SoundManager.shared.playAndPauseAll()
                self?.playingState(observable: isEntirePlaying)         // Control Bar의 Play 버튼 활성화 여부 전달
        }).disposed(by: disposeBag)
        
//        timerButtonTouching
//            .subscribe(onNext: { [weak self] _ in })
//            .disposed(by: disposeBag)
        
        reloading
            .do(onNext: { _ in reloadingCollection.onNext(Void())})
            .subscribe(onNext: { [weak self] _ in
            self?.applyMixPlayerToCollection()
            self?.playingState(observable: isEntirePlaying)
        }).disposed(by: disposeBag)
    }
    
    /**
     SoundMixView에서 플레이된 Mix 플레이 리스트의 사운드의 재생 여부 (isSelected)를 변경해
     MainViewController의 CollectionView에서 선택 여부를 결정하는 메소드
     */
    private func applyMixPlayerToCollection() {
        // isSelected를 먼저 전부 false 처리를 해준후 아래에서 재생 중인 사운드의 isSelected를 true로 바꿔준다.
        for i in 0..<soundItems.count {
            soundItems[i].isSelected = false
        }
        
        SoundManager.shared.audioPlayers.forEach { key, players in
            soundItems.forEach { soundItemModel in
                if soundItemModel.title == key { // key값 변형 필요 switch 추천
                    if key == "BirdSound" {
                        soundItems[0].isSelected = true
                    } else if key == "HighWaySound" {
                        soundItems[1].isSelected = true
                    } else if key == "WaterSound" {
                        soundItems[2].isSelected = true
                    }
                }
            }
        }
    }
    
    /**
     플레이 버튼 활성화 여부를 체크해 이벤트로 보내는 메서드
     */
    private func playingState(observable: BehaviorRelay<Bool>) {
        var nowPlaying = false
        
        _ = SoundManager.shared.audioPlayers.mapValues({ player in      // audioPlayers(재생목록)에 플레이중인 player가 있다면 true를 보낸다. 반대 상황은 false를 보낸다.
            if player.isPlaying {
                nowPlaying = true
            }
        })
        if nowPlaying {
            observable.accept(true)
        } else {
            observable.accept(false)
        }
    }
}
