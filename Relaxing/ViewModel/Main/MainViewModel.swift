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
            SoundItemModel(image: UIImage(named: "Down Tempo_Icon")!, title: "Down Tempo"),
            SoundItemModel(image: UIImage(named: "Bonfire_Icon")!, title: "Bonfire"),
            SoundItemModel(image: UIImage(named: "Rain 1_Icon")!, title: "Rain 1"),
            SoundItemModel(image: UIImage(named: "Rain 2_Icon")!, title: "Rain 2"),
            SoundItemModel(image: UIImage(named: "River_Icon")!, title: "River"),
            SoundItemModel(image: UIImage(named: "Waterfall_Icon")!, title: "Waterfall"),
            SoundItemModel(image: UIImage(named: "Forest_Icon")!, title: "Forest"),
            SoundItemModel(image: UIImage(named: "Wave 1_Icon")!, title: "Wave 1"),
            SoundItemModel(image: UIImage(named: "Wave 2_Icon")!, title: "Wave 2"),
            SoundItemModel(image: UIImage(named: "Wind 1_Icon")!, title: "Wind 1"),
            SoundItemModel(image: UIImage(named: "Wind 2_Icon")!, title: "Wind 2"),
            SoundItemModel(image: UIImage(named: "Cave_Icon")!, title: "Cave"),
            SoundItemModel(image: UIImage(named: "Bird_Icon")!, title: "Bird"),
            SoundItemModel(image: UIImage(named: "Criket Crying_Icon")!, title: "Criket Crying"),
            SoundItemModel(image: UIImage(named: "Cicada_Icon")!, title: "Cicada"),
            SoundItemModel(image: UIImage(named: "Library_Icon")!, title: "Library"),
            SoundItemModel(image: UIImage(named: "Temple_Icon")!, title: "Temple"),
            SoundItemModel(image: UIImage(named: "Highway_Icon")!, title: "Highway"),
            SoundItemModel(image: UIImage(named: "Firework_Icon")!, title: "Firework"),
            SoundItemModel(image: UIImage(named: "Clock_Icon")!, title: "Clock"),
            SoundItemModel(image: UIImage(named: "Pencil_Icon")!, title: "Pencil"),
            SoundItemModel(image: UIImage(named: "Fan_Icon")!, title: "Fan"),
        ]
        
        soundData = [
            DownTempo(),
            Bonfire(),
            Rain1(),
            Rain2(),
            River(),
            Waterfall(),
            Forest(),
            Wave1(),
            Wave2(),
            Wind1(),
            Wind2(),
            Cave(),
            Bird(),
            CriketCrying(),
            Cicada(),
            Library(),
            Temple(),
            Highway(),
            Firework(),
            Clock(),
            Pencil(),
            Fan()
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
        
        reloading
            .do(onNext: { _ in reloadingCollection.onNext(Void())})
            .subscribe(onNext: { [weak self] _ in
            self?.applyMixPlayerToCollection()
            self?.playingState(observable: isEntirePlaying)
        }).disposed(by: disposeBag)
                
        
        // Timer Finish
                
        TimerManager.shared.timerFinished.subscribe(onNext: { [weak self] _ in
            SoundManager.shared.audioPlayers.removeAll()
            self?.applyMixPlayerToCollection()
            self?.playingState(observable: isEntirePlaying)
            reloadingCollection.onNext(Void())
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
        
//        SoundManager.shared.audioPlayers.forEach { key, players in
//            soundItems.forEach { soundItemModel in
//                if soundItemModel.title == key { // key값 변형 필요 switch 추천
//                    if key == "BirdSound" {
//                        soundItems[0].isSelected = true
//                    } else if key == "HighWaySound" {
//                        soundItems[1].isSelected = true
//                    } else if key == "WaterSound" {
//                        soundItems[2].isSelected = true
//                    }
//                }
//            }
//        }
        
        SoundManager.shared.audioPlayers.forEach { key, players in
            soundItems.forEach { soundItemModel in
                if soundItemModel.title == key {
                    switch key {
                    case "Down Tempo":
                        soundItems[0].isSelected = true
                    case "Bonfire":
                        soundItems[1].isSelected = true
                    case "Rain 1":
                        soundItems[2].isSelected = true
                    case "Rain 2":
                        soundItems[3].isSelected = true
                    case "River":
                        soundItems[4].isSelected = true
                    case "Waterfall":
                        soundItems[5].isSelected = true
                    case "Forest":
                        soundItems[6].isSelected = true
                    case "Wave 1":
                        soundItems[7].isSelected = true
                    case "Wave 2":
                        soundItems[8].isSelected = true
                    case "Wind 1":
                        soundItems[9].isSelected = true
                    case "Wind 2":
                        soundItems[10].isSelected = true
                    case "Cave":
                        soundItems[11].isSelected = true
                    case "Bird":
                        soundItems[12].isSelected = true
                    case "Criket Crying":
                        soundItems[13].isSelected = true
                    case "Cicada":
                        soundItems[14].isSelected = true
                    case "Library":
                        soundItems[15].isSelected = true
                    case "Temple":
                        soundItems[16].isSelected = true
                    case "Highway":
                        soundItems[17].isSelected = true
                    case "Firework":
                        soundItems[18].isSelected = true
                    case "Clock":
                        soundItems[19].isSelected = true
                    case "Pencil":
                        soundItems[20].isSelected = true
                    case "Fan":
                        soundItems[21].isSelected = true
                    default:
                        return
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
