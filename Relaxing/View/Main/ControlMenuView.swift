//
//  TestView.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/20.
//

import Foundation
import UIKit
import SnapKit
import Then

class ControlMenuView: UIView {
    // MARK: - Views
    
    var menuButton = UIView().then {
        $0.backgroundColor = .clear
    }
    var menuIcon = UIImageView().then {
        $0.image = UIImage(named: "menuIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    var playButton = UIView().then {
        $0.backgroundColor = .clear
    }
    var playIcon = UIImageView().then {
        $0.image = UIImage(named: "playIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    var soundMixButton = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var soundMixIcon = UIImageView().then {
        $0.image = UIImage(named: "mixIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    var timerButton = UIView().then {
        $0.backgroundColor = .clear
    }
    var timerIcon = UIImageView().then {
        $0.image = UIImage(named: "clockIcon")
        $0.contentMode = .scaleAspectFit
    }
    
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    /**
     뷰 스타일 설정
     */
    private func configureStyle() {
        self.backgroundColor = UIColor(red: 0.20, green: 0.30, blue: 0.40, alpha: 1.00).withAlphaComponent(0.98)
        
        menuIcon.tintColor = .limeWhite
        playIcon.tintColor = .limeWhite
        soundMixIcon.tintColor = .limeWhite
        timerIcon.tintColor = .limeWhite
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add SubViews
        self.addSubview(menuButton)
        self.addSubview(playButton)
        self.addSubview(soundMixButton)
        self.addSubview(timerButton)
        
        menuButton.addSubview(menuIcon)
        playButton.addSubview(playIcon)
        soundMixButton.addSubview(soundMixIcon)
        timerButton.addSubview(timerIcon)
        
        // Constraints
        menuButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(menuButton.snp.width).multipliedBy(1)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        // Icon Constraints
        menuIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.bottom.trailing.equalToSuperview().offset(-12)
        }
    }
    
    /**
     Control View를 탭했을때 나타나는 Animation
     */
    func openControlView() {
        
        timerIcon.isHidden = false
        soundMixIcon.isHidden = false
        playIcon.isHidden = false
        
        timerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(4)

            make.height.equalTo(playButton.snp.width).multipliedBy(1)
            make.bottom.equalTo(menuButton.snp.top).offset(-4)

        }

        soundMixButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(playButton.snp.width).multipliedBy(1)
            make.bottom.equalTo(timerButton.snp.top).offset(-4)
        }

        playButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(playButton.snp.width).multipliedBy(1)
            make.bottom.equalTo(soundMixButton.snp.top).offset(-4)
        }
        
        playIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.bottom.trailing.equalToSuperview().offset(-12)
        }

        soundMixIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.bottom.trailing.equalToSuperview().offset(-12)
        }

        timerIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.bottom.trailing.equalToSuperview().offset(-12)
        }
    }
    
    func closeControlView() {
        timerIcon.isHidden = true
        soundMixIcon.isHidden = true
        playIcon.isHidden = true
        
        timerButton.snp.removeConstraints()
        timerIcon.snp.removeConstraints()
        
        soundMixButton.snp.removeConstraints()
        soundMixIcon.snp.removeConstraints()
        
        playButton.snp.removeConstraints()
        playIcon.snp.removeConstraints()
    }
}
