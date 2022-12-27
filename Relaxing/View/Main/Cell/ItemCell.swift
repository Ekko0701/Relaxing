//
//  ItemCell.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit
import SnapKit
import Then

class ItemCell: UICollectionViewCell {
    static let identifier = "ItemCell"
    
    private let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "house")
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.applyPoppins(style: .semiBold, size: 14, color: .black)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyle() {
        self.layer.applyBorder(color: .clear, radius: 14)
    
    }
    
    /**
     셀 레이아웃 설정
     */
    private func configureLayout() {
        
        // Add Subviews
        contentView.addSubview(titleImage)
        contentView.addSubview(titleLabel)
        
        // AutoLayout
        titleImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-8)
            make.width.height.equalToSuperview().multipliedBy(0.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(with: SoundItemModel) {
        titleImage.image = with.image
        titleLabel.text = with.title.localized()
        if with.isSelected {
            backgroundColor = UIColor(red: 0.38, green: 0.83, blue: 0.67, alpha: 0.4)
            titleLabel.textColor = .limeWhite
            titleImage.tintColor = .limeWhite
        } else {
            backgroundColor = UIColor.black.withAlphaComponent(0.7)
            titleLabel.textColor = .limeWhite
            titleImage.tintColor = .limeWhite
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


