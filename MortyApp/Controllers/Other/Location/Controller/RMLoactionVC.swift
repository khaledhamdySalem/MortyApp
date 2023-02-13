//
//  RMLoactionViewController.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import UIKit

final class RMLoactionVC: UIViewController {
    
    private let locationView = RMLoactionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addRightNavigationTab()
    }
    
    private func configureView() {
        title = "Location"
        view.backgroundColor = .systemBackground
        view.addSubview(locationView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addRightNavigationTab() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTabShare))
    }
    
    @objc private func didTabShare() {
        //TO Do SOMETHING
    }
}
