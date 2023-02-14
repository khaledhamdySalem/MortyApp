//
//  LocationDetailsViewViewModel.swift
//  MortyApp
//
//  Created by KH on 14/02/2023.
//


import Foundation

protocol RMLocationDetailsViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailsViewViewModel {
    
    private var episodeUrl: URL?
    public weak var delegate: RMLocationDetailsViewViewModelDelegate?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createViewModels()
            delegate?.didFetchLocationDetails()
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
        let location = dataTuple.location
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type ", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: location.created)
            ]),
            .characters(viewModel: dataTuple.characters.compactMap({
                RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image))}))
        ]
    }
    
    public func fetchLocationData() {
        guard let url = episodeUrl, let request = RMRequest(url: url) else { return }
        
        RMService.shared.excute(request: request,
                                expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location: model)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func fetchRelatedCharacters(location: RMLocation) {
        let characterUrl: [URL] = location.residents.compactMap({URL(string: $0)})
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
                location: location,
                characters: characters
            )
        }
    }
}


