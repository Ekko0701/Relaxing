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
    private let mixTitle = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.applyPoppins(style: .bold, size: 11, color: .black)
    }
    
    private let subTitle = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.applyPoppins(style: .bold, size: 11, color: .black)
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.addSubview(mixTitle)
        contentView.addSubview(subTitle)
        
        // Constraints
        mixTitle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
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
