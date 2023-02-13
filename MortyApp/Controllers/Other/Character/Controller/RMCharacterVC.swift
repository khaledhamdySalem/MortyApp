//
//  RMCharacterVC.swift
//  MortyApp
//
//  Created by KH on 05/02/2023.
//

import UIKit

class RMCharacterVC: UIViewController {
    
    private var characterListView = RMCharacterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addRightNavigationTab()
    }
    
    private func addRightNavigationTab() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTabShare))
    }
    
    @objc private func didTabShare() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureView() {
        title = "Character"
        view.addSubview(characterListView)
        characterListView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RMCharacterVC: RMCharacterViewProtocol {
    func didTabOnCell(_ character: RMCharacter) {
        let viewModel = CharacterDetailsViewViewModel(character: character)
        let detailsVC = RMCharacterDetailsViewController(viewModel: viewModel)
        detailsVC.navigationItem.largeTitleDisplayMode = .never
        self.show(detailsVC, sender: self)
    }
}
