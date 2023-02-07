//
//  RMCharacterView.swift
//  MortyApp
//
//  Created by KH on 05/02/2023.
//

import UIKit

class RMCharacterView: UIView {
    
    private let viewModel = RMCharacterViewModel()
   
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        viewModel.fetcharacters()
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
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0) { [weak self] in
            self?.collectionView.alpha = 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
