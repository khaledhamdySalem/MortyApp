//
//  RMSearchViewController.swift
//  MortyApp
//
//  Created by KH on 12/02/2023.
//

import UIKit

// 1- Dynamic Search Option View
// 2- Searching -> Sending Api To Get Search Results
// 3- Render Result
// 4- Render No Result

final class RMSearchViewController: UIViewController {
    
    // MARK: - Properties
    private let searchView: RMSearchView
    private let viewModel: RMSearchViewViewModel
    
    struct Config {
        enum `Type`: String {
            case character = "Search Character" // -> status || gender
            case episode = "Search Episode" // None
            case location = "Search Location" //  -> type
        }
        
        let type: `Type`
    }
    
    // MARK: - Init
    init(config: Config) {
        searchView = .init(frame: .zero, viewModel: RMSearchViewViewModel(config: config))
        self.viewModel = RMSearchViewViewModel(config: config)
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addSearchButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = viewModel.config.type.rawValue
        view.addSubviews(searchView)
        searchView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(didTapExcuteSearch))
    }
    
    @objc private func didTapExcuteSearch() {
        viewModel.excuteSearch()
    }
    
    // MARK: - Excute Search API
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Delegate
extension RMSearchViewController: RMSearchViewDelegate {
    func rmSearchView(_ inputView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: option) { [weak self] selection in
            self?.searchView.selectOption(option: option, selection: selection)
//            self?.viewModel.set(value: selection, for: option)
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        self.present(vc, animated: true)
    }
}

