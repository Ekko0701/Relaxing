//
//  SettingCell.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/25.
//

import Foundation
import UIKit
import SnapKit
import Then

class SettingCell: UITableViewCell {
    static let identifier = "SettingCell"
    
    // MARK: - UI
    private let containerView = UIView()
    
    private let cellTitle = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.applyPoppins(style: .semiBold, size: 17, color: .limeWhite)
    }
    
    private let cellAccessory = UIView()
    
    private let cellAccessoryImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "cellArrow")
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureStyle()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    /**
     View 스타일 설정
     */
    private func configureStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.4)
        cellAccessoryImg.tintColor = .limeWhite
        
        //cellAccessory.backgroundColor = .yellow
        //cellAccessoryImg.backgroundColor = .red
    }
    
    /**
     셀 레이아웃 설정
     */
    private func configureLayout() {
        // Add Subview
        contentView.addSubview(containerView)
        
        containerView.addSubview(cellTitle)
        containerView.addSubview(cellAccessory)
        
        cellAccessory.addSubview(cellAccessoryImg)
        
        // Constraints
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cellTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
        
        cellAccessory.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(cellAccessory.snp.height)
        }
        
        cellAccessoryImg.snp.makeConstraints { make in
            make.width.height.equalTo(15)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
            //make.edges.equalToSuperview()
        }
    }
    
    func configure(cellTitle: String) {
        self.cellTitle.text = cellTitle
    }
}
