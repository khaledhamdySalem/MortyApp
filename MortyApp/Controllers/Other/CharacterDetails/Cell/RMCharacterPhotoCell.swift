//
//  RMCharacterPhotoCell.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import UIKit

class RMCharacterPhotoCell: UICollectionViewCell {
    
    public static let identifier = "RMCharacterPhotoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraint()
    }
    
    private func addConstraint() {
        
    }
    
    private func configureView() {
        backgroundColor = .systemRed
    }
    
    public func configure(with viewModel: RMCharacterPhotoCellViewModel) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
