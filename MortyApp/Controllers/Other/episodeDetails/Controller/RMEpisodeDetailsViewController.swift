//
//  RMEpisodeDetailsViewController.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import UIKit

class RMEpisodeDetailsViewController: UIViewController {
    private var viewModeL: RMEpisdoeDetailsViewViewModel
    private let detailView = RMEpisdoeDetailsView()

    init(url: URL?) {
        self.viewModeL = RMEpisdoeDetailsViewViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
        addRightNavigationTab()
        viewModeL.delegate = self
        viewModeL.fetchEpisodeData()
        detailView.delegate = self
    }
    
    private func addRightNavigationTab() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTabShare))
    }
    
    @objc private func didTabShare() {
        //TO Do SOMETHING
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "Episode"
    }
    
    private func setupConstraints() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMEpisodeDetailsViewController: RMEpisdoeDetailsViewViewModelDelegate {
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModeL)
    }
}

extension RMEpisodeDetailsViewController: RMEpisdoeDetailsViewDelegate {
    func rmEpisodeDetails(_ character: RMCharacter) {
        let viewModel = CharacterDetailsViewViewModel(character: character)
        let vc = RMCharacterDetailsViewController(viewModel: viewModel)
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
