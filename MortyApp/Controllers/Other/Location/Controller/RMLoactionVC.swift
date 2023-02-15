//
//  RMLoactionViewController.swift
//  RickAndMorty
//
//  Created by KH on 28/01/2023.
//

import UIKit

final class RMLoactionVC: UIViewController {
    
    private let locationView = RMLoactionView()
    private let viewModel = RMLoactionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addRightNavigationTab()
        viewModel.fetchLocations()
        viewModel.rmLoactionViewModelDelegate = self
        locationView.delegate = self
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
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        show(vc, sender: self)
    }
}

extension RMLoactionVC: RMLoactionViewModelDelegate {
    func didFetchIntialLocations() {
        locationView.configure(with: viewModel)
    }
}

extension RMLoactionVC: RMLocationViewModelDelegate {
    func didSelectLoactionFromList(_ location: RMLocation) {
        //let viewModel = RMLocationDetailsViewViewModel(location: location)
        let locationDetailsVC = RMLocationDetailsViewController(location: location)
        locationDetailsVC.title = location.name
        locationDetailsVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.show(locationDetailsVC, sender: self)
    }
}
