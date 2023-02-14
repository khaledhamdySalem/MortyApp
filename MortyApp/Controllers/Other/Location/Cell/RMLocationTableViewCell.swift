//
//  RMLocationTableViewCell.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "RMLocationTableViewCell"
    
    // MARK: -- Variable
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20,
                                       weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15,
                                       weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15,
                                       weight: .light)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        contentView.addSubviews(nameLabel, typeLabel, dimensionLabel)
        accessoryType = .disclosureIndicator
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            dimensionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dimensionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        [nameLabel, typeLabel, dimensionLabel].forEach({$0.text = nil})
    }
    
    func configure(with viewModel: RMLocationTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimensionLabel.text = viewModel.dimension
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
