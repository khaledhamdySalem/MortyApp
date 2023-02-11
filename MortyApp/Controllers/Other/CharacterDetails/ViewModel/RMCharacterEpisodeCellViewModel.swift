//
//  RMCharacterEpisodeCellViewModel.swift
//  MortyApp
//
//  Created by KH on 10/02/2023.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCellViewModel {
    
    private let episodeDataUrl: URL?
    private var isFetching: Bool = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else { return }
            dataBlock?(model)
        }
    }
    
    public func registerForData(_ block: ((RMEpisodeDataRender) -> Void)?) {
        dataBlock = block
    }
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl, let request = RMRequest(url: url) else { return}
        isFetching = true
        
        RMService.shared.excute(request: request, expecting: RMEpisode.self) {[weak self] result in
            switch result {
            case .success(let episode):
                DispatchQueue.main.async {
                    self?.episode = episode
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
