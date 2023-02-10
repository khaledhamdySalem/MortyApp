//
//  RMCharacterCollectionViewCellViewModel.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import UIKit

final class RMCharacterCollectionViewCellViewModel {
    fileprivate var characterName: String
    fileprivate let characterStatus: RMCharacterStatus
    fileprivate let characterImageUrl: URL?
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var name: String {
        return characterName
    }
    
    public var status: String {
        return "Status: " + characterStatus.rawValue
    }
    
    public func fetchImage(complition: @escaping (Result<Data, Error>) -> Void) {
        guard let url = characterImageUrl else { return }
        RMImageLoader.shared.downloadImage(url: url, complition: complition)
    }
}

extension RMCharacterCollectionViewCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
