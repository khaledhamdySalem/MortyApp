//
//  RMEpisdoeDetailsView.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import UIKit

protocol RMEpisdoeDetailsViewDelegate: AnyObject {
    func rmEpisodeDetails(_ character: RMCharacter)
}

class RMEpisdoeDetailsView: UIView {
    
    private var viewModel: RMEpisdoeDetailsViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.isHidden = false
            self.collectionView?.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    
    // MARK: - Views
    var collectionView: UICollectionView?
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    weak var delegate: RMEpisdoeDetailsViewDelegate?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        addSubviews(collectionView, spinner)
        self.collectionView = collectionView
        spinner.startAnimating()
    }
    
    private func addConstraints() {
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
    
    public func configure(with viewModel: RMEpisdoeDetailsViewViewModel) {
        self.viewModel = viewModel
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.layout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }
    
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels[sectionIndex]  else { fatalError("UnSupported")}
        switch sections {
        case .information(_):
            return createInformationLayout()
        case .characters(_):
            return createCharactersLayout()
        }
    }
    
    private func createInformationLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem( layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(80)),
            
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharactersLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem( layoutSize: .init(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)))
       
        item.contentInsets = .init(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(250)),
            
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RMEpisdoeDetailsView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = viewModel?.cellViewModels[section] else { return 0}
        switch sectionType {
        case .information(let viewModels):
            return viewModels.count
        case .characters(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = viewModel?.cellViewModels[indexPath.section] else { return UICollectionViewCell()}
        switch sectionType {
        case .information(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier, for: indexPath) as! RMEpisodeInfoCollectionViewCell
            cell.configure(with: viewModels[indexPath.item])
            return cell
        case .characters(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as! RMCharacterCollectionViewCell
            cell.configure(with: viewModels[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let sectionType = viewModel?.cellViewModels[indexPath.section] else { return }
        switch sectionType {
        case .information:
            break
        case .characters:
            guard let character = viewModel?.character(at: indexPath.item) else { return  }
            self.delegate?.rmEpisodeDetails(character)
        }
    }
}
