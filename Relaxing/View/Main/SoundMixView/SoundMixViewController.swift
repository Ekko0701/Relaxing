//
//  SoundMixViewController.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/11.
//

import Foundation
import UIKit
import Then
import SnapKit
import PanModal
import RxCocoa
import RxSwift

/**
 사운드 믹스 View Controller - 사운드 볼륨, 사운드 추가, 사운드 제거
 */
class SoundMixViewController: UIViewController {
    // MARK: - Properties
    var soundTable: UITableView!
    
    let disposeBag = DisposeBag()
    
    let viewModel: SoundMixViewModelType
    
    var isShortFormEnabled = true
    
    // MARK: - Initializers
    init(viewModel: SoundMixViewModelType = SoundMixViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBlue
        configureSoundTable()
        configureLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: -
    /**
     SoundTableView 설정
     */
    private func configureSoundTable() {
        soundTable = UITableView()
        
        // Attach Delegate , DataSource
        soundTable.delegate = self
        soundTable.dataSource = self
        
        // Register
        soundTable.register(SoundTableCell.self, forCellReuseIdentifier: SoundTableCell.identifier)
    }
    
    // MARK: - Layout
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add Subviews
        view.addSubview(soundTable)
        
        // AutoLayout
        soundTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableView Delegate
extension SoundMixViewController: UITableViewDelegate {
    
}

// MARK: - UITableView DataSource
extension SoundMixViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.playerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundTableCell.identifier, for: indexPath) as? SoundTableCell else { return UITableViewCell() }
        
        cell.configure(data: viewModel.playerItems[indexPath.row])
        
        // Volume Slider Change
        let volumeObservable = cell.volumeSlider.rx.value.map { VolumeData(itemNumber: indexPath, volumeValue: $0) }
        volumeObservable.bind(to: viewModel.volumeChange).disposed(by: disposeBag)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

// MARK: - Pan Modal Presentable
extension SoundMixViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return soundTable
    }
    
    var longFormHeight: PanModalHeight {
        return isShortFormEnabled ? .contentHeight(500.0) : self.longFormHeight
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var shouldRoundTopCorners: Bool {
        return true
    }
}
