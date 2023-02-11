//
//  RMCharacterPhotoCellViewModel.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import Foundation

final class RMCharacterPhotoCellViewModel {
    
    private let imageString: String
    
    init(imageString: String) {
        self.imageString = imageString
    }
    
    public func fetchPhoto(complition: @escaping (Data) -> Void) {
        guard let url = URL(string: imageString) else { return }
        RMImageLoader.shared.downloadImage(url: url) { data in
            switch data {
            case .success(let data):
                complition(data)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
