//
//  MixViewController.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/09.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift

class MixViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    var viewModel: MixViewModelType
    
    // MARK: - UI
    var backgroundView = UIView()
    
    var mixTableView: UITableView!
    
    // MARK: - Initializers
    init(viewModel: MixViewModelType = MixViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // mix를 새로 추가하면 viewModel을 다시 설정하고 tableView를 reload 해줘야 한다
        viewModel = MixViewModel()
        mixTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemYellow
        configureTableView()
        configureLayout()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureStyle()
    }
    
    /**
     View Style 설정 
     */
    private func configureStyle() {
        backgroundView.setGradient(firstColor: UIColor.gradientBlue, secondColor: UIColor.gradientGreen)
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        // AddSubviews
        view.addSubview(backgroundView)
        view.addSubview(mixTableView)
        
        // Constraints
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mixTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /**
     테이블뷰 설정
     */
    private func configureTableView() {
        mixTableView = UITableView()
        
        mixTableView.backgroundColor = .clear
        
        // Attach Delegate , DataSource
        mixTableView.delegate = self
        mixTableView.dataSource = self
        
        // Register
        mixTableView.register(MixItemCell.self, forCellReuseIdentifier: MixItemCell.identifier)
    }
    
    /**
     Binding 설정
     */
    private func setupBindings() {
        /** cell 터치시 viewModel의 mixTouch로 이벤트 전달*/
        mixTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.viewModel.mixTouch.onNext(indexPath)
        }).disposed(by: disposeBag)
    }
}

// MARK: - UITableView Delegate
extension MixViewController: UITableViewDelegate {
}

// MARK: - UITableView DataSource
extension MixViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mixItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MixItemCell.identifier, for: indexPath) as? MixItemCell else { return UITableViewCell() }
        
        cell.configure(data: viewModel.mixItems[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.viewModel.deleteMix.onNext(indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
    
}
