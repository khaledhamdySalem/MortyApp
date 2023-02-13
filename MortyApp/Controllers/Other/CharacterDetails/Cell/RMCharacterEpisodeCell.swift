//
//  RMCharacterEpisodeCell.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import UIKit

class RMCharacterEpisodeCell: UICollectionViewCell {
    
    public static let identifier = "RMCharacterEpisodeCell"
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20,
                                       weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22,
                                       weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18,
                                       weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setLayout()
        addConstraint()
    }
    
    private func configureView() {
        contentView.backgroundColor = .tertiarySystemBackground
    }
    
    private func addConstraint() {
        
        let verticalStackView = UIStackView()
        contentView.addSubviews(verticalStackView)
       
        verticalStackView.addArrangedSubview(seasonLabel)
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(airDateLabel)
        verticalStackView.distribution = .fillProportionally
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCellViewModel) {
        viewModel.registerForData { [weak self] episode in
            self?.seasonLabel.text = "Episode " + episode.episode
            self?.airDateLabel.text = "Aired on " + episode.air_date
            self?.nameLabel.text = episode.name
        }
        viewModel.fetchEpisode()
        
        contentView.layer.borderColor = viewModel.borderColor.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    private func setLayout() {
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
