//
//  ControlBarView.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/10.
//

import Foundation
import UIKit
import SnapKit
import Then

/**
 사운드 플레이시 나오는 하단 Control Bar
 */
class ControlBarView: UIView {
    var itemStack = UIStackView().then{
        $0.distribution = .fillEqually
    }
    
    /** 전체 사운드 pause, stop 컨트롤 버튼 */
    var playButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.circle"), for: .normal)
    }
    
    /** 볼륨 조절 믹스 버튼 */
    var volumeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "speaker.circle"), for: .normal)
    }
    
    /** 타이머 설정 버튼 */
    var timerButton = UIButton().then {
        $0.setImage(UIImage(systemName: "clock.circle"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     뷰 스타일 설정
     */
    private func configureStyle() {
        self.backgroundColor = .black
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add SubViews
        self.addSubview(itemStack)
        
        // Add Stacks
        itemStack.addArrangedSubview(volumeButton)
        itemStack.addArrangedSubview(playButton)
        itemStack.addArrangedSubview(timerButton)
        
        // AutoLayout
        itemStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
