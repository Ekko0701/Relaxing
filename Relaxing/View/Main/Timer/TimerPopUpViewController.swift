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
import RxGesture

/**
    타이머 설정 ViewController (Pop up)
 */
class TimerPopUpViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let viewModel: TimerPopUpViewModelType
    
    // MARK: - Views
    var behindView = UIView().then {
        $0.backgroundColor = .clear
    }
    
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
        $0.setTitle("시작", for: .normal)
    }
    
    var exitButton = UIButton().then {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    // MARK: - Configure
    private func configureStyle() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.backgroundView.layer.applyBorder(color: .clear, radius: 12)
        self.startButton.layer.applyBorder(color: .clear, radius: 12)
        self.exitButton.layer.applyBorder(color: .clear, radius: 12)
        
        datePicker.setValue(UIColor.limeWhite, forKeyPath: "textColor")
        
        startButton.backgroundColor = UIColor(red: 0.40, green: 0.54, blue: 0.51, alpha: 1.00)
        exitButton.backgroundColor = .systemGray

    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add Subviews
        view.addSubview(behindView)
        view.addSubview(backgroundView)
        
        backgroundView.addSubview(datePicker)
        backgroundView.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(exitButton)
        buttonStack.addArrangedSubview(startButton)
        
        
        // AutoLayout
        behindView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
        /** 배경 탭하면 view 사라짐*/
        behindView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.behindViewTouch.onNext(Void())
            }).disposed(by: disposeBag)
        
        exitButton.rx.tap
            .bind(to: viewModel.exitButtonTouch)
            .disposed(by: disposeBag)
        
        viewModel.dismissTimerView.bind { [weak self] _ in
            //print("Dd")
            self?.dismiss(animated: false)
        }.disposed(by: disposeBag)
    }
}

//MARK: - Preview

#if DEBUG
import SwiftUI
struct TimerPopUpViewController_Previews: PreviewProvider {
    static var previews: some View {
        TimerPopUpViewController().getPreview()
            .ignoresSafeArea()
    }
}
/// option + command +enter -> 접었다 폈다
/// option + command + p -> 미리보기 실행
#endif
