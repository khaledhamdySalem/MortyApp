//
//  RMEpisodeListViewController.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import UIKit

class RMEpisodeListViewController: UIViewController {
    
    private var episodeListView = RMEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addSearchButton()
    }
    
    private func configureView() {
        title = "Episode"
        view.backgroundColor = .systemBackground
        view.addSubview(episodeListView)
        episodeListView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.show(vc, sender: self)
    }
}

extension RMEpisodeListViewController: RMEpisodeListViewProtocol {
    func didTabOnCell(_ episode: RMEpisode) {
        guard let url = URL(string: episode.url) else { return }
        let controller = RMEpisodeDetailsViewController(url: url)
        controller.navigationItem.largeTitleDisplayMode = .never
        self.show(controller, sender: self)
    }
}

