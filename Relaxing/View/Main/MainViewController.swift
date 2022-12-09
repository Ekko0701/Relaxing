//
//  ViewController.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import AVFoundation

class MainViewController: UIViewController {

    let viewModel = MainViewModel()
    
    let disposeBag = DisposeBag()
    
    var collectionView: UICollectionView!
    
    /** 오디오 플레이어 변수*/
    var player: AVAudioPlayer?
    var soundPlayers = [AVAudioPlayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemYellow
        
        configureCollectionView()
        configureLayout()
        setBindings()
        
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add Subviews
        view.addSubview(collectionView)
        
        // AutoLayout
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /**
     UICollectionView 설정
     */
    private func configureCollectionView() {
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        // Attach Delegate & DataSource
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Register
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
    }
    
    /**
     UICollectionView Compositional Layout 생성
     */
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout{ (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333333333),
                                                     heightDimension: .fractionalWidth(0.333333333))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.top = 5
                item.contentInsets.bottom = 5
                item.contentInsets.trailing = 5
                item.contentInsets.leading = 5

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.333333333))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
            else {
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                     heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalWidth(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                 subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                
                return section
            }
        }
    }
    
    /**
     Binding 설정
     */
    private func setBindings() {
        // CollectionView item Select 액션
        collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            print("CollectionView item Selected - \(indexPath)")
            if indexPath.item == 0 {
                guard let sound = self?.viewModel.soundData[indexPath.item] else { return }
                SoundManager.shared.play(sound: sound)
            } else if indexPath.item == 1 {
                SoundManager.shared.play(sound: HighWaySound())
            } else if indexPath.item == 2 {
                guard let sound = self?.viewModel.soundData[indexPath.item] else { return }
                SoundManager.shared.play(sound: sound)
            } else if indexPath.item == 3 {
                guard let sound = self?.viewModel.soundData[indexPath.item] else { return }
                SoundManager.shared.play(sound: sound)
            } else {
                print(SoundManager.shared.audioPlayers)
            }
        }).disposed(by: disposeBag)
    }
    
    /**
     오디오 재생 (사용 X)
     로컬에 있는 soundName이라는 mp3파일을 재생한다.
     */
    private func playAudio(soundName: String, type: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: type) else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    /**
     여러 오디오 재생 (사용 X)
     */
    private func playSounds(sound: Sound) {
        //sound.isNowPlaying = !sound.isNowPlaying
        
        let fileName = sound.getFileName()
        let fileExtension = sound.getFileExtension()
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return }
        
        guard let soundPlayer = try? AVAudioPlayer(contentsOf: url) else { return }
        
        soundPlayer.numberOfLoops = -1
        soundPlayer.volume = 1
        soundPlayer.play()
        
        soundPlayers.append(soundPlayer)
    }
}

//MARK: - UICollectionView Delegate & DataSource
extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sampleDatas.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.sampleDatas[indexPath.row])
        return cell
    }
}


