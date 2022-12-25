//
//  SettingHeaderView.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/25.
//

import Foundation
import UIKit

final class SettingTableViewHeader: UITableViewHeaderFooterView {
    static let identifier = "SettingTableViewHeader"
    
    private let headerLabel = UILabel().then {
        $0.applyPoppins(text: "Header", style: .semiBold, size: 18, color: .limeWhite)
        
    }
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureStyle()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    /**
     View 스타일 설정
     */
    private func configureStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.4)
    }
    
    /**
     셀 레이아웃 설정
     */
    private func configureLayout() {
        contentView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-4)
            make.leading.equalToSuperview().offset(8)
        }
    }
    
    func configure(headerTitle: String) {
        self.headerLabel.text = headerTitle
    }
}
