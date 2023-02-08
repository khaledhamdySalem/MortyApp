//
//  RMCharacterCollectionViewCellViewModel.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    private let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
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
        
        guard let url = characterImageUrl else {
            complition(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                complition(.failure(URLError(.badServerResponse)))
                return
            }
            complition(.success(data))
        }
        task.resume()
    }
}
