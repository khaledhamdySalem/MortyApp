//
//  RMEpisodeListViewViewModel.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import Foundation
import UIKit

protocol RMEpisodeListViewViewModelProtocol: NSObject {
    func didInitialEpisdoe()
    func didSelectEpisdoe(_ episode: RMEpisode)
    func didLoadMoreEpisdoes(with indexpaths: [IndexPath])
}

final class RMEpisodeListViewViewModel: NSObject {
    
    private let borderColors: [UIColor] = [
        .systemBlue,
        .systemGreen,
        .systemRed,
        .systemOrange
    ]
    
    // MARK: -
    private var episdoes: [RMEpisode] = [] {
        didSet {
            episdoes.forEach { episode in
                let viewModel = RMCharacterEpisodeCellViewModel(
                    episodeDataUrl: URL(string: episode.url),
                    borderColor: borderColors.randomElement() ?? .systemBlue)
                
                if !cellViewModel.contains(viewModel) {
                    cellViewModel.append(viewModel)
                }
            }
        }
    }
    
    // MARK: -- Variables
    private var cellViewModel = [RMCharacterEpisodeCellViewModel]()
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    private var isLoadingMoreEpisode: Bool = false
    
    // MARK: - Delegate
    public weak var delegate: RMEpisodeListViewViewModelProtocol?
    
    // MARK: - Fetch Character
    public func fetchEpisode() {
        let request = RMRequest(endPoint: .episode)
        RMService.shared.excute(request: request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.episdoes = results
                self?.apiInfo = responseModel.info
                DispatchQueue.main.async {
                    self?.delegate?.didInitialEpisdoe()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // MARK: -- Handle Pagination
    private func fetchAdditionalEpisode() {
        guard !isLoadingMoreEpisode else { return }
        isLoadingMoreEpisode = true
        guard let nextUrl = apiInfo?.next, let url = URL(string: nextUrl) else { return }
        guard let request = RMRequest(url: url) else { return }
        // Get Data
        RMService.shared.excute(request: request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                self.apiInfo = responseModel.info
                let moreResults = responseModel.results
                
                let originCount = self.episdoes.count
                let newCount = moreResults.count
                let total = originCount + newCount
                let startingIndex = total - newCount
                let indexPathsTo: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({return IndexPath(row: $0, section: 0)})
                
                // Add Data for character list array
                self.episdoes.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreEpisdoes(with: indexPathsTo)
                    self.isLoadingMoreEpisode = false
                }
            case .failure(let error):
                print(String(describing: error))
                self?.isLoadingMoreEpisode = false
            }
        }
    }
    
    private var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - Handle CollectionView Datasource and Delegate
extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCell.identifier, for: indexPath) as! RMCharacterEpisodeCell
        cell.configure(with: cellViewModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        return .init(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selection = episdoes[indexPath.item]
        delegate?.didSelectEpisdoe(selection)
    }
}

// MARK: - Handle Show Footer Cell And Pagination
extension RMEpisodeListViewViewModel {
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
            
            self.fetchAdditionalEpisode()
        }
    }
}
