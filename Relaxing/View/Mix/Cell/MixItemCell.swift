//
//  MixItemCell.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/15.
//

import Foundation
import UIKit
import SnapKit
import Then

class MixItemCell: UITableViewCell {
    static let identifier = "MixItemCell"
    
    // MARK: - UI
    private let containerView = UIView()
    
    private let mixTitle = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.applyPoppins(style: .bold, size: 17, color: .limeWhite)
    }
    
    private let subTitle = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.applyPoppins(style: .semiBold, size: 13, color: .limeWhite)
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        containerView.backgroundColor = .black.withAlphaComponent(0.4)
        self.backgroundColor = .clear
    }
    
    /**
     셀 레이아웃 설정
     */
    private func configureLayout() {
        // Add Subview
        contentView.addSubview(containerView)
        
        containerView.addSubview(mixTitle)
        containerView.addSubview(subTitle)
        
        // Constraints
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.bottom.trailing.equalToSuperview().offset(-8)
        }
        
        mixTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mixTitle.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
    }
    
    func configure(data: ViewMix) {
        mixTitle.text = data.mixTitle
        subTitle.text = data.subTitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
