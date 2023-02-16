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
    private let viewModel: RMSearchViewViewModel
    private var searchView: RMSearchView
    
    // MARK: - Struct
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
        self.viewModel = .init(config: config)
        self.searchView = .init(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        addSearchButton()
        searchView.presentKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: - ConfigureView
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = viewModel.config.type.rawValue
        view.addSubviews(searchView)
        searchView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - Add SearchButton Nav
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(didTapExcuteSearch))
    }
    
    // MARK: - Excute Search API
    @objc private func didTapExcuteSearch() {
        viewModel.excuteSearch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Delegate
extension RMSearchViewController: RMSearchViewDelegate, RMSearchOptionPickerViewControllerDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelection option: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptionPickerViewController(option: option)
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func didSelectOption(_ selection: String, option: RMSearchInputViewViewModel.DynamicOption) {
        DispatchQueue.main.async {
            self.viewModel.set(value: selection, for: option)
        }
        
        self.searchView.didSelectOptionFromList(option: option, value: selection)
    }
}

