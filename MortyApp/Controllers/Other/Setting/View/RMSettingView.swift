//
//  RMSettingView.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import UIKit

class RMSettingView: UIView {

    let viewModel = RMSettingViewViewModel(cellViewModels: RMSettingOptions.allCases.compactMap({.init(type: $0)}))
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RMSettingTableViewCell.self, forCellReuseIdentifier: RMSettingTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension RMSettingView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RMSettingTableViewCell.identifier, for: indexPath) as! RMSettingTableViewCell
        cell.configure(with: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: "https://www.google.com") else { return }

        switch viewModel.cellViewModels[indexPath.row].type {
        case .rateApp:
            UIApplication.shared.open(url)
        case .contactUs:
            UIApplication.shared.open(url)
        case .terms:
            UIApplication.shared.open(url)
        case .privacy:
            UIApplication.shared.open(url)
        case .apiReferance:
            UIApplication.shared.open(url)
        case .viewSeries:
            UIApplication.shared.open(url)
        case .viewCode:
            UIApplication.shared.open(url)
        }
    }
}
