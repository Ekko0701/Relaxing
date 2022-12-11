//
//  SoundCell.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/11.
//

import Foundation
import UIKit
import SnapKit
import Then

class SoundTableCell: UITableViewCell {
    static let identifier = "SoundTableCell"
    
    // MARK: - UI
    private let titleStack = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    private let titleImage = UIImageView().then {
        $0.image = UIImage(systemName: "gear")
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.applyPoppins(text: "테스트", style: .regular, size: 11, color: .black)
    }
    
    private let volumeSlider = UISlider().then {
        $0.minimumValue = 0
        $0.maximumValue = 100
        $0.value = 100
        $0.tintColor = .systemGreen
    }
    
    private let deleteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "x.square.fill"), for: .normal)
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemRed
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    /**
     셀 레이아웃 설정
     */
    private func configureLayout() {
        // Add SubView
        contentView.addSubview(titleStack)
        contentView.addSubview(volumeSlider)
        contentView.addSubview(deleteButton)
        
        // Add Arrange Subview
        titleStack.addArrangedSubview(titleImage)
        titleStack.addArrangedSubview(titleLabel)
        
        // AutoLayout
        titleStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(titleStack.snp.trailing).offset(8)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-8)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(deleteButton.snp.height).multipliedBy(1)
            make.trailing.equalToSuperview().offset(-8)
        }
        
    }
}
