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

class TestView: UIView {
    
    var playButton = UIView().then {
        $0.backgroundColor = .blue
    }
    
    var soundMixButton = UIView().then {
        $0.backgroundColor = .red
    }
    
    var timerButton = UIView().then {
        $0.backgroundColor = .white
    }
    
    var menuButton = UIView().then {
        $0.backgroundColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        backgroundColor = .lime
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyle() {
    
    }
    
    private func configureLayout() {
        
        // Add SubViews
        self.addSubview(playButton)
        self.addSubview(soundMixButton)
        self.addSubview(timerButton)
        self.addSubview(menuButton)
        
        // Constarints
        
//        playButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(4)
//            make.trailing.equalToSuperview().offset(-4)
//            make.height.equalTo(playButton.snp.width).multipliedBy(1)
//            make.bottom.equalTo(self.snp.bottom).offset(-4)
//        }
        
//        soundMixButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(4)
//            make.trailing.equalToSuperview().offset(-4)
//            make.height.equalTo(playButton.snp.width).multipliedBy(1)
//            make.bottom.equalTo(self.snp.bottom).offset(-4)
//        }
        
//        timerButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(4)
//            make.trailing.equalToSuperview().offset(-4)
//            make.height.equalTo(playButton.snp.width).multipliedBy(1)
//            make.bottom.equalTo(self.snp.bottom).offset(-4)
//
//        }
        
        menuButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(menuButton.snp.width).multipliedBy(1)
            make.bottom.equalToSuperview().offset(-4)
        }
    }
    
    func updateTestView() {
//        timerButton.snp.remakeConstraints{ make in
//            make.leading.equalToSuperview().offset(4)
//            make.trailing.equalToSuperview().offset(-4)
//            make.height.equalTo(playButton.snp.width).multipliedBy(1)
//            make.bottom.equalTo(self.snp.bottom).offset(-4)
//        }
        
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

    }
}
