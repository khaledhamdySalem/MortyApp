//
//  RMCharacterViewModel.swift
//  MortyApp
//
//  Created by KH on 05/02/2023.
//

import Foundation
import UIKit

final class RMCharacterViewModel: NSObject {
    
    public func fetcharacters() {
        let request = RMRequest(endPoint: .character)
        RMService.shared.excute(request: request, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
}
