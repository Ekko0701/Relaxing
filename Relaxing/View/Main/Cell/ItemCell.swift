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
    
    let titleImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "house")
    }
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.applyPoppins(style: .regular, size: 11, color: .black)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.top.equalToSuperview().offset(8)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.leading.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(with: SoundItemModel) {
        titleImage.image = with.image
        titleLabel.text = with.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
