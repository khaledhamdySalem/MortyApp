//
//  RMSettingViewController.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import UIKit

final class RMSettingVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        title = "Settings"
        view.backgroundColor = .systemBackground
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
