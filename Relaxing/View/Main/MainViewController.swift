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
import RxViewController
import RxCocoa
import AVFoundation
import PanModal

class MainViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: MainViewModelType
    
    let disposeBag = DisposeBag()
    
    /** 오디오 플레이어 관련 변수 */
    //var player: AVAudioPlayer?
    //var soundPlayers = [AVAudioPlayer]()
    
    // MARK: - Views
    var collectionView: UICollectionView!
    
    let controlBarView = ControlBarView()
    
    
    // MARK: - Initializers
    init(viewModel: MainViewModelType = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        view.addSubview(controlBarView)
        
        // AutoLayout
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        controlBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
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
        /** CollectionView item Select 액션 */
        collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.soundTouch.onNext(indexPath)        // viewModel에 soundTouch 이벤트 전달
            self?.collectionView.reloadItems(at: [indexPath])   // 터치시 cell 스타일 변화 적용
        }).disposed(by: disposeBag)
        
        //MARK: - Control Bar View Binding
        /** Play Button을 탭하면 viewModel의 playButtonTouch로 이벤트 전달. */
        controlBarView.playButton.rx.tap
            .bind(to: viewModel.playButtonTouch)
            .disposed(by: disposeBag)
        
        /** Play Button 이미지 변경 ViewModel의 isEntirePlayed를 구독*/
        viewModel.isEntirePlayed
            .do(onNext: { [weak self] isPlaying in
                if isPlaying {
                    self?.controlBarView.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
                } else {
                    self?.controlBarView.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
                }
            })
            .subscribe(onNext: { _ in () })
            .disposed(by: disposeBag)
                
        /** Sound Mix Button을 탭하면 viewModel의 soundMixButtonTouch로 이벤트 전달. */
        controlBarView.soundMixButton.rx.tap
            .bind(to: viewModel.soundMixButtonTouch)
            .disposed(by: disposeBag)
        
        /** Show Sound Mix VC */
        viewModel.showSoundMixVC.subscribe(onNext: { _ in
            self.presentPanModal(SoundMixViewController())
            
        }).disposed(by: disposeBag)
        
        /** Timer Button 탭 */
        controlBarView.timerButton.rx.tap
            .bind(to: viewModel.timerButtonTouch)
            .disposed(by: disposeBag)
        
        /** Show Timer VC Pop Up*/
        viewModel.showTimerPopUp.subscribe(onNext: { _ in
            print("show Timer Pop Up ")
            self.present(TimerPopUpViewController(), animated: true)
        }).disposed(by: disposeBag)
        
        /** View Will Appear */
        let viewWillAppear = rx.viewWillAppear.map { _ in () }
        viewWillAppear.bind(to: viewModel.mainViewWillAppear).disposed(by: disposeBag)
        
        /** Reload CollectionView*/
        viewModel.reloadCollection.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
        
    }
}

//MARK: - UICollectionView Delegate & DataSource
extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.soundItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        cell.configure(with: viewModel.soundItems[indexPath.row])
        return cell
    }
}

