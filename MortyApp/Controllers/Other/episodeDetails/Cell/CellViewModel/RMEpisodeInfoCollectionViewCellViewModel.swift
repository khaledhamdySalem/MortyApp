//
//  RMEpisodeInfoCollectionViewCellViewModel.swift
//  MortyApp
//
//  Created by KH on 13/02/2023.
//

import Foundation

final class RMEpisodeInfoCollectionViewCellViewModel {
    
    public let title: String
    public let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
