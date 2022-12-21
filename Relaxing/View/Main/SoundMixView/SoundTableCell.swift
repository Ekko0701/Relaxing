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
    let containerView = UIView()
    
    private let titleStack = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    private let titleImage = UIImageView().then {
        $0.image = UIImage(systemName: "gear")
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.applyPoppins(text: "테스트", style: .regular, size: 14, color: .limeWhite)
    }
    
    let volumeSlider = UISlider().then {
        $0.minimumValue = 0
        $0.maximumValue = 100
        $0.value = 100
        $0.tintColor = .systemGreen
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemRed
        configureLayout()
        configureStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    /**
     스타일 설정
     */
    private func configureStyle() {
        containerView.layer.applyBorder(color: .clear, radius: 14)
        //containerView.backgroundColor = .black.withAlphaComponent(0.4)
        containerView.backgroundColor = .limeWhite
        self.backgroundColor = .clear
    }
    
    /**
     셀 레이아웃 설정
     */
    private func configureLayout() {
        // Add Subview
        contentView.addSubview(containerView)
        
        titleStack.addArrangedSubview(titleImage)
        titleStack.addArrangedSubview(titleLabel)
        
        containerView.addSubview(titleStack)
        containerView.addSubview(volumeSlider)
        
        // Constraints
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        titleImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(4)
            make.height.equalTo(titleImage.snp.width)
        }
        
        titleStack.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(volumeSlider.snp.leading).offset(-8)
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.width.equalTo(self.frame.width * 0.85)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    /**
     Configure
     */
    func configure(data: ViewSoundMix) {
        self.titleImage.image = data.titleImage
        self.titleLabel.text = data.title.localized()
        self.volumeSlider.value = data.playerVolume * 100
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
