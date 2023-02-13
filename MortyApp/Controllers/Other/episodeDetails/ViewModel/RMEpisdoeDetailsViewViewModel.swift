//
//  RMEpisdoeDetailsViewViewModel.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import Foundation

protocol RMEpisdoeDetailsViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisdoeDetailsViewViewModel {
    
    private var episodeUrl: URL?
    public weak var delegate: RMEpisdoeDetailsViewViewModelDelegate?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels = [SectionType]()
    
    init(url: URL?) {
        self.episodeUrl = url
    }
    public func character(at Index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        return dataTuple.characters[Index]
    }
    
    private func createViewModels() {
        guard let dataTuple = dataTuple else { return }
        let episode = dataTuple.episode
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date ", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: episode.created)
            ]),
            .characters(viewModel: dataTuple.characters.compactMap({
                RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image))}))
        ]
    }
    
    public func fetchEpisodeData() {
        guard let url = episodeUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.excute(request: request,
                                expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episode: model)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func fetchRelatedCharacters(episode: RMEpisode) {
        let characterUrl: [URL] = episode.characters.compactMap({URL(string: $0)})
        let requests: [RMRequest] = characterUrl.compactMap({RMRequest(url: $0)})
        
        let group = DispatchGroup()
        var characters = [RMCharacter]()
        
        for request in requests {
            group.enter()
            RMService.shared.excute(request: request,
                                    expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure(_):
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dataTuple = (
                episode,
                characters
            )
        }
    }
}


