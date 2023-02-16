//
//  RMSearchOptionPickerViewController.swift
//  MortyApp
//
//  Created by KH on 16/02/2023.
//

import UIKit

class RMSearchOptionPickerViewController: UIViewController {
    
    private let option :RMSearchInputViewViewModel.DynamicOption
    public weak var delegate: RMSearchOptionPickerViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    init(option: RMSearchInputViewViewModel.DynamicOption) {
        self.option = option
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RMSearchOptionPickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let option = option.choices[indexPath.item]
        cell.textLabel?.text = option.uppercased()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choices.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let choise = option.choices[indexPath.item]
        dismiss(animated: true)
        delegate?.didSelectOption(choise, option: option)
    }
}

protocol RMSearchOptionPickerViewControllerDelegate: AnyObject {
    func didSelectOption(_ selection: String, option: RMSearchInputViewViewModel.DynamicOption)
}
