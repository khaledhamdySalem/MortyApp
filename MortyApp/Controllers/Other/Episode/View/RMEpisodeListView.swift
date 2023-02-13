//
//  RMEpisodeListView.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import UIKit

import UIKit

protocol RMEpisodeListViewProtocol: NSObject {
    func didTabOnCell(_ episdoe: RMEpisode)
}

class RMEpisodeListView: UIView {
    
    private let viewModel = RMEpisodeListViewViewModel()
    public weak var delegate: RMEpisodeListViewProtocol?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 10, right: 10)
        
        collectionView.register(RMCharacterEpisodeCell.self,
                                forCellWithReuseIdentifier: RMCharacterEpisodeCell.identifier)
        
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraint()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(collectionView, spinner)
        viewModel.fetchEpisode()
        spinner.startAnimating()
        configureCollectionView()
    }
    
    private func addConstraint() {
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
    
    private func configureCollectionView() {
        viewModel.delegate = self
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMEpisodeListView: RMEpisodeListViewViewModelProtocol {
    
    func didInitialEpisdoe() {
        collectionView.isHidden = false
        spinner.stopAnimating()
        collectionView.reloadData()
        UIView.animate(withDuration: 0.2, delay: 0) { [weak self] in
            self?.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreEpisdoes(with indexpaths: [IndexPath]) {
        collectionView.performBatchUpdates({[weak self] in
            self?.collectionView.insertItems(at: indexpaths)
        })
    }
    
    func didSelectEpisdoe(_ episode: RMEpisode) {
        delegate?.didTabOnCell(episode)
    }
}


   
