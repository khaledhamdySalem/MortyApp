//
//  RMSearchInputView.swift
//  MortyApp
//
//  Created by KH on 15/02/2023.
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)//
}

final class RMSearchInputView: UIView {
    
    // MARK: - Views
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search "
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var stackView: UIStackView?
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOption else {
                return
            }
            
            let options = viewModel.options
            createOptionSelectionViews(options)
        }
    }
    
    public weak var delegate: RMSearchInputViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configreView()
        addConstraints()
    }
    
    private func configreView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(searchBar)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 6
        stackView.alignment = .center
        addSubview(stackView)
     
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return stackView
    }
    
    private func createOptionSelectionViews(_ options: [RMSearchInputViewViewModel.DynamicOption]) {
        let stackView = createOptionStackView()
        self.stackView = stackView
        
        for (index, value) in options.enumerated() {
            createButtonWithTag(value, index, stackView)
        }
    }
    
    private func createButtonWithTag(_ value: RMSearchInputViewViewModel.DynamicOption, _ index: Int, _ stackView: UIStackView) {
        let button = UIButton()
        button.setTitle(value.rawValue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton(sender: )), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.tag = index
        button.backgroundColor = .secondarySystemFill
        stackView.addArrangedSubview(button)
    }
    
    @objc private func didTapButton(sender: UIButton) {
        guard let options = viewModel?.options else { return }
        let selected =  options[sender.tag]
        delegate?.rmSearchInputView(self, didSelectOption: selected)
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    public func configureView(viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceHolder
        self.viewModel = viewModel
    }
    
    public func selectOption(option: RMSearchInputViewViewModel.DynamicOption, selection: String) {
        guard let buttons = stackView?.arrangedSubviews as? [UIButton] else { return }
        guard let index = viewModel?.options.firstIndex(of: option) else { return }
        let button = buttons[index]
        button.setTitle(selection.uppercased(), for: .normal)
        button.setTitleColor(.link, for: .normal)
    }

required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
