//
//  RMCharacterDetailsView.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import UIKit

class RMCharacterDetailsView: UIView {
    
    var collectionView: UICollectionView?
    let viewModel: CharacterDetailsViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    init(frame: CGRect, viewModel: CharacterDetailsViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraint()
    }
    
    private func  addConstraint() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterPhotoCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCell.identifier)
        collectionView.register(RMCharacterInformationCell.self, forCellWithReuseIdentifier: RMCharacterInformationCell.identifier)
        collectionView.register(RMCharacterEpisodeCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch viewModel.sections[sectionIndex] {
        case .photo:
            return viewModel.createPhotoLayout()
        case .information:
            return viewModel.createInformationLayout()
        case .episodes:
            return viewModel.createEpisodeLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
