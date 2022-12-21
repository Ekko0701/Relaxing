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
import RxGesture
import AVFoundation
import PanModal

class MainViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: MainViewModelType
    
    let disposeBag = DisposeBag()
    
    var controlViewIsOn = false
    
    // MARK: - Views
    var backgroundView = UIView()
    
    var collectionView: UICollectionView!
    
    let controlView = ControlMenuView()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureStyle()
    }
    
    /**
     UI 스타일 설정
     */
    private func configureStyle() {
        backgroundView.setGradient(firstColor: UIColor.gradientBlue, secondColor: UIColor.gradientGreen)
        controlView.layer.cornerRadius = controlView.frame.width / 2
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add Subviews
        
        view.addSubview(backgroundView)
        view.addSubview(collectionView)
        view.addSubview(controlView)
        
        // AutoLayout
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        controlView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(self.view.frame.width / 6.5)
        }
    }
    /**
     UICollectionView 설정
     */
    private func configureCollectionView() {
        let layout = createCompositionalLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
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
        
        // MARK: - Control Bar View Binding
        controlView.playButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.playButtonTouch.onNext(Void())
            })
            .disposed(by: disposeBag)
        
        /** Play Button 이미지 변경 ViewModel의 isEntirePlayed를 구독*/
        viewModel.isEntirePlayed
            .do(onNext: { [weak self] isPlaying in
                if isPlaying {
                    self?.controlView.playIcon.image = UIImage(named: "pauseIcon")
                } else {
                    self?.controlView.playIcon.image = UIImage(named: "playIcon")
                }
            })
            .subscribe(onNext: { _ in () })
            .disposed(by: disposeBag)
                
        /** Sound Mix Button을 탭하면 viewModel의 soundMixButtonTouch로 이벤트 전달. */
        controlView.soundMixButton.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.viewModel.soundMixButtonTouch.onNext(Void())
            }).disposed(by: disposeBag)
        
        /** Show Sound Mix VC */
        viewModel.showSoundMixVC.subscribe(onNext: { _ in
            self.presentPanModal(SoundMixViewController())
        }).disposed(by: disposeBag)
        
        /** Timer Button 탭 */
        controlView.timerButton.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: {[weak self] _ in
                self?.viewModel.timerButtonTouch.onNext(Void())
            }).disposed(by: disposeBag)
        
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
        
        // MARK: - Control View Binding
        /** Tap Control View */
        controlView.menuButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.controlViewIsOn.toggle()
                self?.controlMenuViewAnimation()
            })
            .disposed(by: disposeBag)
    }
    
    
    /**
     ControlView를 탭했을때 나타나는 animation
     */
    private func controlMenuViewAnimation() {
        if controlViewIsOn {
            UIView.animate(withDuration: 0.5, delay: 0,options: .curveEaseInOut) {
                self.controlView.snp.updateConstraints { make in
                    make.height.equalTo(self.view.frame.width / 6.5 * 3.85)
                }
                self.controlView.openControlView()
                self.controlView.superview?.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseInOut) {
                self.controlView.snp.updateConstraints { make in
                    make.height.equalTo(self.view.frame.width / 6.5)
                }
                self.controlView.closeControlView()
                self.controlView.superview?.layoutIfNeeded()
            }
        }
        
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

