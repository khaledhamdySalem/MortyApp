//
//  RMCharacterPhotoCell.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import UIKit

class RMCharacterPhotoCell: UICollectionViewCell {
    
    public static let identifier = "RMCharacterPhotoCell"
    
    private let photoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraint()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        addSubview(photoImageView)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configure(with viewModel: RMCharacterPhotoCellViewModel) {
        viewModel.fetchPhoto { [weak self] data in
            DispatchQueue.main.async {
                self?.photoImageView.image = UIImage(data: data)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
