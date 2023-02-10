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
    func didLoadMoreCharacters(with indexpaths: [IndexPath])
}

final class RMCharacterViewModel: NSObject {
    
    // MARK: -
    private var characters: [RMCharacter] = [] {
        didSet {
            characters.forEach { character in
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                
                if !cellViewModel.contains(viewModel) {
                    cellViewModel.append(viewModel)
                }
            }
        }
    }
   
    // MARK: -- Variables
    private var cellViewModel = [RMCharacterCollectionViewCellViewModel]()
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    private var isLoadingMoreCharacter: Bool = false
 
    // MARK: - Delegate
    public weak var delegate: RMCharacterViewModelProtocol?
    
    // MARK: - Fetch Character
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
    
    // MARK: -- Handle Pagination
    private func fetchAdditionalCharacter() {
        guard !isLoadingMoreCharacter else { return }
        isLoadingMoreCharacter = true
        guard let nextUrl = apiInfo?.next, let url = URL(string: nextUrl) else { return }
        guard let request = RMRequest(url: url) else { return }
        // Get Data
        RMService.shared.excute(request: request, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                self.apiInfo = responseModel.info
                let moreResults = responseModel.results
                
                let originCount = self.characters.count
                let newCount = moreResults.count
                let total = originCount + newCount
                let startingIndex = total - newCount
                let indexPathsTo: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({return IndexPath(row: $0, section: 0)})
                
                // Add Data for character list array
                self.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreCharacters(with: indexPathsTo)
                    self.isLoadingMoreCharacter = false
                }
            case .failure(let error):
                print(String(describing: error))
                self?.isLoadingMoreCharacter = false
            }
        }
    }
    
    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - Handle CollectionView Datasource and Delegate
extension RMCharacterViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as! RMCharacterCollectionViewCell
        cell.configure(with: cellViewModel[indexPath.item])
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
}

// MARK: - Handle Show Footer Cell And Pagination
extension RMCharacterViewModel {
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard shouldShowLoadMoreIndicator, !cellViewModel.isEmpty else {
            return
        }
        if cellViewModel.count - 1 == indexPath.item {
            
            self.fetchAdditionalCharacter()
        }
      }
}

// MARK: - Handle Show pagination data
//extension RMCharacterViewModel: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard shouldShowLoadMoreIndicator, !cellViewModel.isEmpty else {
//            return
//        }
//
//        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { [weak self] timer in
//            let offset = scrollView.contentOffset.y
//            let totalContentHeight = scrollView.contentSize.height
//            let fixedTotalScrollViewHeight = scrollView.frame.size.height
//
//            if offset >= (totalContentHeight - fixedTotalScrollViewHeight) {
//                self?.fetchAdditionalCharacter()
//            }
//            timer.invalidate()
//        }
//    }
//}
