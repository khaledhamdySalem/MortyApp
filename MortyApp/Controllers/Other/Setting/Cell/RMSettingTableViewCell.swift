//
//  SettingTableViewCell.swift
//  MortyApp
//
//  Created by KH on 17/02/2023.
//

import UIKit

class RMSettingTableViewCell: UITableViewCell {
    
    static let identifier = "RMSettingTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let containerImageView: UIImageView = {
       let containerImage = UIImageView()
        containerImage.translatesAutoresizingMaskIntoConstraints = false
        containerImage.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        containerImage.layer.cornerRadius = 4
        return containerImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        backgroundColor = .tertiarySystemFill
        contentView.addSubviews(titleLabel, containerImageView)
        containerImageView.addSubview(image)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerImageView.widthAnchor.constraint(equalToConstant: 35),
            containerImageView.heightAnchor.constraint(equalToConstant: 35),
            
            image.topAnchor.constraint(equalTo: containerImageView.topAnchor, constant: 4),
            image.leadingAnchor.constraint(equalTo: containerImageView.leadingAnchor, constant: 4),
            image.trailingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: -4),
            image.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: -4),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerImageView.trailingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func configure(with viewModel: SettingTableViewCellViewModel) {
        titleLabel.text = viewModel.displayTitle
        image.image = viewModel.displayImage
        containerImageView.backgroundColor = viewModel.showContainerColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
