//
//  RMLoactionViewController.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import UIKit

final class RMLoactionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        view.backgroundColor = .systemBackground
        addRightNavigationTab()
    }
    
    private func addRightNavigationTab() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTabShare))
    }
    
    @objc private func didTabShare() {
        //TO Do SOMETHING
    }
}
