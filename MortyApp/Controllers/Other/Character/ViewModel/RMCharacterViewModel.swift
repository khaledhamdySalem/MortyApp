//
//  RMCharacterViewModel.swift
//  MortyApp
//
//  Created by KH on 05/02/2023.
//

import Foundation
import UIKit

protocol RMCharacterViewModelProtocol: NSObject {
    func didInitialCharacter()
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterViewModel: NSObject {
    
    private var characters: [RMCharacter] = [] {
        didSet {
            characters.forEach { character in
                characterCellViewModel.append(RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)))
            }
        }
    }
    
    private var characterCellViewModel = [RMCharacterCollectionViewCellViewModel]()
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    public weak var delegate: RMCharacterViewModelProtocol?
    private var isLoadingMoreCharacter: Bool = false
    
    public func fetcharacters() {
        let request = RMRequest(endPoint: .character)
        RMService.shared.excute(request: request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                self?.apiInfo = responseModel.info
                DispatchQueue.main.async {
                    self?.delegate?.didInitialCharacter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    private func fetchAdditionalCharacter() {
        
    }
}

extension RMCharacterViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterCellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as! RMCharacterCollectionViewCell
        cell.configure(with: characterCellViewModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return .init(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        delegate?.didSelectCharacter(character)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard !shouldShowLoadMoreIndicator else {
            return .init(width: collectionView.frame.width, height: 100)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier, for: indexPath) as! RMFooterLoadingCollectionReusableView
        footer.startAnimation()
        return footer
    }
}


extension RMCharacterViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator, !isLoadingMoreCharacter else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let fixedTotalScrollViewHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeight - fixedTotalScrollViewHeight) {
            fetchAdditionalCharacter()
            isLoadingMoreCharacter = true
        }
    }
}
