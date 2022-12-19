//
//  TimerPopUpViewController.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/18.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift

/**
    타이머 설정 ViewController (Pop up)
 */
class TimerPopUpViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let viewModel: TimerPopUpViewModelType
    
    // MARK: - Views
    var backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.8)
    }
    var datePicker = UIDatePicker().then {
        $0.tintColor = .white
        $0.datePickerMode = .countDownTimer
    }
    
    var buttonStack = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    var startButton = UIButton().then {
        $0.backgroundColor = .systemRed
        $0.setTitle("시작", for: .normal)
    }
    
    var cancelButton = UIButton().then {
        $0.backgroundColor = .systemYellow
        $0.setTitle("나가기", for: .normal)
    }
    
    // MARK: - Initializers
    init(viewModel: TimerPopUpViewModelType = TimerPopUpViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureLayout()
        setupBindings()
    }
    
    // MARK: - Configure
    private func configureStyle() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add Subviews
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(datePicker)
        backgroundView.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(startButton)
        buttonStack.addArrangedSubview(cancelButton)
        
        // AutoLayout
        backgroundView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(backgroundView.snp.width).multipliedBy(0.7)
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
    }
    
    /**
     Binding 설정
     */
    private func setupBindings() {
        /** Start Button 터치시 viewModel의 startButtonTouch로 타이머 시간 전달 */
        startButton.rx.tap.bind { [weak self] _ in
            let timer = self?.datePicker.countDownDuration
            self?.viewModel.startButtonTouch.onNext(timer ?? 0.0)
        }.disposed(by: disposeBag)
    }
    
    
}
