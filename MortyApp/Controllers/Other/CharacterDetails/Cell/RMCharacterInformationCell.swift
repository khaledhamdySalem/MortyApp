//
//  RMCharacterInformationCell.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import UIKit

class RMCharacterInformationCell: UICollectionViewCell {
    
    public static let identifier = "RMCharacterInformationCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraint()
    }
    
    private func addConstraint() {
        
    }
    
    private func configureView() {
        backgroundColor = .systemBrown
    }
    
    public func configure(with viewModel: RMCharacterInformationCellViewModel) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
