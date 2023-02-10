//
//  CharacterDetailsViewController.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import UIKit

class RMCharacterDetailsViewController: UIViewController {
    
    private let viewModel: CharacterDetailsViewViewModel
    
    private let detailsView: RMCharacterDetailsView
    
    init(viewModel: CharacterDetailsViewViewModel) {
        self.viewModel = viewModel
        self.detailsView = RMCharacterDetailsView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addRightNavigationTab()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubviews(detailsView)
        detailsView.collectionView?.dataSource = self
        detailsView.collectionView?.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addRightNavigationTab() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTabShare))
    }
    
    @objc private func didTabShare() {
        //TO Do SOMETHING
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMCharacterDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.sections[indexPath.section] {
        case .photo(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCell.identifier, for: indexPath) as! RMCharacterPhotoCell
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInformationCell.identifier, for: indexPath) as! RMCharacterInformationCell
            cell.configure(with: viewModels[indexPath.item])
            return cell
        case .episodes(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCell.identifier, for: indexPath) as! RMCharacterEpisodeCell
            cell.configure(with: viewModels[indexPath.item])
            return cell
        }
    }
}
