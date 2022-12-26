//
//  LicenseWebView.swift
//  Relaxing
//
//  Created by Ekko on 2022/12/26.
//

import Foundation
import UIKit
import RxSwift
import WebKit
import Then
import SnapKit

class LicenseWebViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    var viewModel: LicenseWebViewModelType
    
    // MARK: - UI
    
    let testLabel = UILabel()
    
    let webView = WKWebView()
    
    // MARK: - Initializers
    init(viewModel: LicenseWebViewModelType = LicenseWebViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureLayout()
        configureWebView()
        
    }
    
    // MARK: - Configure
    
    private func configureStyle() {
        view.backgroundColor = .systemYellow
    }
    
    private func configureLayout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureWebView() {
        webView.navigationDelegate = self
        if let url = URL(string: viewModel.httpAddress) {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }
    
    private func testing() {
        view.addSubview(testLabel)
        
        testLabel.text = viewModel.httpAddress
        
        testLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension LicenseWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("로드완료")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            self.dismiss(animated: true)
        }
        
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
