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
    let disposeBag = DisposeBag()
    
    let viewModel: SoundMixViewModelType
    
    var isShortFormEnabled = true
    
    // MARK: - Views
    var soundTable: UITableView!
    
    var saveButton = UIButton().then {
        $0.setTitle("내 믹스 저장하기", for: .normal)
    }
    
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
        self.view.backgroundColor = .black
        configureSoundTable()
        configureLayout()
        setupBindings()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Configure
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
        view.addSubview(saveButton)
        view.addSubview(soundTable)
        
        // AutoLayout
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        soundTable.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    private func setupBindings() {
        // Save Button Touch Event
        let saveButtonObservable = saveButton.rx.tap
        saveButtonObservable.bind(to: viewModel.saveButtonTouch).disposed(by: disposeBag)
        
        // Show Alert
        viewModel.showMixAlert.bind { _ in
            let alert = UIAlertController(title: "믹스 타이틀을 입력하세요", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "저장", style: .default) { [weak self] (ok) in
                let inputTitle = alert.textFields?[0].text
                self?.viewModel.alertOKTouch.onNext(inputTitle ?? "")
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancel) in
                print("cancel pressed")
            }
            
            alert.addTextField { textField in
                textField.placeholder = "Title"
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }.disposed(by: disposeBag)
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
        return 70
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
