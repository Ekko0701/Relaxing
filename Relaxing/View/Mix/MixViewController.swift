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
    
    
    // MARK: - UI
    var mixTableView: UITableView!
    
    // MARK: - Initializers
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemYellow
        configureLayout()
        
    }
    
    /**
     레이아웃 설정
     */
    private func configureLayout() {
        
    }
    
    /**
     테이블뷰 설정
     */
    private func configureTableView() {
        
    }
    
    private func setupBindings() {
    /**
     Binding 설정
     */
    }
}
