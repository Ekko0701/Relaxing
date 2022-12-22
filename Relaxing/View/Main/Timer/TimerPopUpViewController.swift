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
import Lottie

/**
    타이머 설정 ViewController (Pop up)
 */
class TimerPopUpViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let viewModel: TimerPopUpViewModelType
    
    // MARK: - Views
    private var behindView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var backgroundView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.8)
    }
    private var datePicker = UIDatePicker().then {
        $0.tintColor = .white
        $0.datePickerMode = .countDownTimer
    }
    
    private var buttonStack = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.axis = .horizontal
        $0.spacing = 8
    }
    
    private var startButton = UIButton().then {
        $0.setTitle("시작", for: .normal)
    }
    
    private var exitButton = UIButton().then {
        $0.setTitle("나가기", for: .normal)
    }
    
    private var activeView = UIView()
    
    private var animationView: LottieAnimationView?
    
    private var timerCancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
    }
    
    private var timerLabel = UILabel().then {
        $0.textAlignment = .center
        $0.applyPoppins(text:"00:00", style: .regular, size: 24, color: .limeWhite)
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
        configureAnimation()
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

        activeView.isHidden = true
        activeView.backgroundColor = .black.withAlphaComponent(0.8)
        self.timerCancelButton.layer.applyBorder(color: .clear, radius: 12)
        timerCancelButton.backgroundColor = .systemGray
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add Subviews
        view.addSubview(behindView)
        view.addSubview(backgroundView)
        view.addSubview(activeView)
        
        backgroundView.addSubview(datePicker)
        backgroundView.addSubview(buttonStack)
        
        buttonStack.addArrangedSubview(exitButton)
        buttonStack.addArrangedSubview(startButton)
        
        activeView.addSubview(animationView!)
        activeView.addSubview(timerCancelButton)
        activeView.addSubview(timerLabel)
        
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
        
        activeView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView)
        }
        
        animationView?.snp.makeConstraints { make in
            //make.top.equalToSuperview().offset(32)
            make.bottom.equalTo(timerLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView!.snp.bottom).offset(8)
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        timerCancelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.leading.equalToSuperview().offset(64)
            make.trailing.equalToSuperview().offset(-64)
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
        
        /** 나가기 Button 터치 */
        exitButton.rx.tap
            .bind(to: viewModel.exitButtonTouch)
            .disposed(by: disposeBag)
        
        /** Dismiss 연결 */
        viewModel.dismissTimerView.bind { [weak self] _ in
            self?.dismiss(animated: false)
        }.disposed(by: disposeBag)
        
        /**
         타이머 실행중 여부 검사
         실행중 이라면 activeView를 보여준다.
         */
        viewModel.timerActivated
            .debug()
            .map{ !$0 }
            .do(onNext: { [weak self] isPlay in
                if isPlay {
                    self?.animationView?.stop()
                } else {
                    self?.animationView?.play()
                }}
            )
            .bind(to: activeView.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.timerActivated
            .bind(to: backgroundView.rx.isHidden)
            .disposed(by: disposeBag)
                
                viewModel.timerString
                .bind(to: timerLabel.rx.text)
                .disposed(by: disposeBag)
                
//                timerCancelButton.rx.tap.bind{ [weak self] _ in
//                    viewModel.cancelButtonTouch.onNext(Void())
//                }.disposed(by: disposeBag)
        
        timerCancelButton.rx.tap.bind(to: viewModel.cancelButtonTouch).disposed(by: disposeBag)
    }
    
    /**
     Animation 설정
     */
    private func configureAnimation() {
        animationView = .init(name: "music_animation")
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        
        
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
