//
//  LocationDetailsViewController.swift
//  MortyApp
//
//  Created by KH on 14/02/2023.
//

import UIKit

class RMLocationDetailsViewController: UIViewController, RMLocationDetailsViewViewModelDelegate, RMLocationDetailsViewDelegate {
    
    fileprivate var viewModeL: RMLocationDetailsViewViewModel
    fileprivate let detailView = RMLocationDetailsView()

    init(location: RMLocation?) {
        let url = URL(string: location?.url ?? "")
        self.viewModeL = RMLocationDetailsViewViewModel(url: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
        addRightNavigationTab()
        viewModeL.delegate = self
        detailView.delegate = self
        viewModeL.fetchLocationData()
    }
    
    private func addRightNavigationTab() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTabShare))
    }
    
    @objc private func didTabShare() {
        //TO Do SOMETHING
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "Location"
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
    
    func rmEpisodeDetails(_ character: RMCharacter) {
        let viewModel = CharacterDetailsViewViewModel(character: character)
        let vc = RMCharacterDetailsViewController(viewModel: viewModel)
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFetchLocationDetails() {
        detailView.configure(with: viewModeL)
    }
}
