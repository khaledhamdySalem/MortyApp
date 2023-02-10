//
//  RMCharacterEpisodeCell.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import UIKit

class RMCharacterEpisodeCell: UICollectionViewCell {
    
    public static let identifier = "RMCharacterEpisodeCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraint()
    }
    
    private func addConstraint() {
        
    }
    
    private func configureView() {
        backgroundColor = .systemBlue
    }
    
    public func configure(with viewModel: RMCharacterEpisodeCellViewModel) {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
