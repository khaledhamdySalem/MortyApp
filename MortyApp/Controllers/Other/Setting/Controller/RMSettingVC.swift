//
//  RMSettingViewController.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import UIKit

final class RMSettingVC: UIViewController {
    
    private let bodyView = RMSettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(bodyView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bodyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bodyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
