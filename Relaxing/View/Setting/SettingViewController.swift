//
//  SettingViewController.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift

class SettingViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let viewModel : SettingTableViewModelType
    
    // MARK: - UI
    var backgroundView = UIView()
    
    var settingTableView: UITableView!
    
    // MARK: - Initializers
    init(viewModel: SettingTableViewModelType = SettingTableViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = .init(style: .dark)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Poppins-SemiBold", size: 17) as Any]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        configureLayout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureStyle()
    }
    
    // MARK: - Configure
    /**
     View Style 설정
     */
    private func configureStyle() {
        navigationController?.isNavigationBarHidden = false
        
        backgroundView.setGradient(firstColor: UIColor.gradientBlue, secondColor: UIColor.gradientGreen)
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // Add SubViews
        view.addSubview(backgroundView)
        view.addSubview(settingTableView)
        
        // Constarints
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    private func configureTableView() {
        settingTableView = UITableView(frame: .zero, style: .insetGrouped)
        
        settingTableView.backgroundColor = .clear
        
        // Attach Delegate , DataSource
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        // Register
        settingTableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        settingTableView.register(SettingTableViewHeader.self, forHeaderFooterViewReuseIdentifier: SettingTableViewHeader.identifier)
        
    }
}

// MARK: - TableView Delegate
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch self .viewModel.headerDataSource[section] {
        case let .license(licenseHeaderModel):
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingTableViewHeader.identifier) as? SettingTableViewHeader else { return UIView() }
            
            header.configure(headerTitle: licenseHeaderModel.title ?? "")
            
            return header
        }
    }
}

// MARK: - TableView DataSource
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self .viewModel.dataSource[section] {
        case let .license(licenseCellModels):
            return licenseCellModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self .viewModel.dataSource[indexPath.section] {
        case let .license(licenseCellModels):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UITableViewCell() }
            let lincenseModel = licenseCellModels[indexPath.row]
            
            cell.configure(cellTitle: lincenseModel.title ?? "")
            
            return cell
        }
    }
    
    
}
