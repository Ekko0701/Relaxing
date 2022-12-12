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
    let background = UIView().then {
        $0.backgroundColor = .systemGray
    }
    
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
        $0.applyPoppins(text: "테스트", style: .regular, size: 11, color: .black)
    }
    
    let volumeSlider = UISlider().then {
        $0.minimumValue = 0
        $0.maximumValue = 100
        $0.value = 100
        $0.tintColor = .systemGreen
    }
    
    let deleteButton = UIButton().then {
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
        // Add Subview
        contentView.addSubview(background)
        
        titleStack.addArrangedSubview(titleImage)
        titleStack.addArrangedSubview(titleLabel)
        
        background.addSubview(titleStack)
        background.addSubview(volumeSlider)
        background.addSubview(deleteButton)
        
        // Constraints
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleStack.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(volumeSlider.snp.leading).offset(-8)
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-8)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(background)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    /**
     Configure
     */
    func configure(data: ViewSoundMix) {
        self.titleImage.image = data.titleImage
        self.titleLabel.text = data.titleLabel
        self.volumeSlider.value = data.playerVolume * 100
    }
}
