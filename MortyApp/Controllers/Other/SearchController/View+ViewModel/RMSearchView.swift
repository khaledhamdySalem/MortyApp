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
    func rmSearchView(_ inputView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

class RMSearchView: UIView {
    
    private let searchNoResultsView = RMNoSearchResultsView()
    private let searchInputView = RMSearchInputView()
    
    private var viewModel: RMSearchViewViewModel
    public weak var delegate: RMSearchViewDelegate?
    
    init(frame: CGRect, viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configureView()
        addConstraints()
        searchInputView.configureView(viewModel: .init(type: viewModel.config.type))
        viewModel.registerOptionChangingBlock { tuple in
            
        }
    }
    
    private func configureView() {
        addSubviews(searchNoResultsView, searchInputView)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        searchInputView.delegate = self
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55: 110),
            
            searchNoResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchNoResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func configure(with viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
    
    public func selectOption(option: RMSearchInputViewViewModel.DynamicOption, selection: String) {
        searchInputView.selectOption(option: option, selection: selection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Delegate

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

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}
