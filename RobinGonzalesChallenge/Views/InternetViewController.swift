//
//  InternetViewController.swift
//  RobinGonzalesChallenge
//
//  Created by Robin Gonzales on 13/10/21.
//

import UIKit
import WebKit

class InternetViewController: UIViewController {

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .zero)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.barTintColor = UIColor(red: 134/255, green: 230/255, blue: 169/255, alpha: 1)
        return toolbar
    }()
    
    private lazy var refreshButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_webRefresh"), style: .plain, target: self, action: #selector(InternetViewController.refreshAction))
        return button
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(InternetViewController.backAction))
        return button
    }()
    
    private lazy var forwardButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: self, action: #selector(InternetViewController.forwardAction))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        loadWebPage()
    }
    
    private func setUpUI() {
        
        toolbar.items = [backButton, refreshButton, forwardButton]
        
        stackView.addArrangedSubview(toolbar)
        stackView.addArrangedSubview(webView)
        
        view.addSubview(stackView)
        
        // create constraint
        let safeArea = view.safeAreaLayoutGuide
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
    }
    
    private func loadWebPage() {
        guard let url = URL(string: NetworkURL.externalWeb)
        else { return }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @objc private func refreshAction() {
        webView.reload()
    }
    
    @objc private func backAction() {
        webView.goBack()
    }
    
    @objc private func forwardAction() {
        webView.goForward()
    }
}
