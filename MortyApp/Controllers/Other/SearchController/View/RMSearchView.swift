//
//  RMSearchView.swift
//  MortyApp
//
//  Created by KH on 15/02/2023.
//

import UIKit

// 1- Show Search Results
// 2- Show No Results View
// 3- Kick off API request

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView,
                      didSelection option: RMSearchInputViewViewModel.DynamicOption)
}

class RMSearchView: UIView {
    
    // MARK: - ViewModel
    private let viewModel: RMSearchViewViewModel
    
    // MARK: - Views
    private let noResultsView = RMNoSearchResultsView()
    private let searchInputView = RMSearchInputView()
    
    // MARK: - Delegate
    public weak var delegate: RMSearchViewDelegate?
    
    
    // MARK: - Init
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        searchInputView.delegate = self
        searchInputView.configure(with: .init(type: viewModel.config.type))
        viewModel.registerOptionChangeBlock { [weak self] tuple in
            self?.searchInputView.update(for: tuple.0, value: tuple.1)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55: 110),
            
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func configure(with viewModel: RMSearchViewViewModel) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
    
    func didSelectOptionFromList(option: RMSearchInputViewViewModel.DynamicOption, value: String) {
        searchInputView.didSelectOptionFromList(option: option, value: value)
    }
    
}

// MARK: - Delegate
extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputOption: RMSearchInputView, option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelection: option)
    }
}

// MARK: - CollectionView
extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
