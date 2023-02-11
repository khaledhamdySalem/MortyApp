//
//  CharacterDetailsViewViewModel.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import UIKit

final class CharacterDetailsViewViewModel {
    
    private let character: RMCharacter
    
    public var episodes: [String] {
        return character.episode
    }
    
    enum SectionType {
        case photo(_ viewModel: RMCharacterPhotoCellViewModel)
        case information(_ viewModel: [RMCharacterInformationCellViewModel])
        case episodes(_ viewModel: [RMCharacterEpisodeCellViewModel])
    }
    
    init(character: RMCharacter) {
        self.character = character
        setSections()
    }
    
    private func setSections() {
        sections = [
            .photo(.init(imageString: character.image)),
            .information([
                .init(type: .status, value: character.status.text),
                .init(type: .gender, value: character.gender.rawValue),
                .init(type: .type, value: character.type),
                .init(type: .species, value: character.species),
                .init(type: .origin, value: character.origin.name),
                .init(type: .location, value: character.location.name),
                .init(type: .created, value: character.created),
                .init(type: .episodeCount, value: "\(character.episode.count)")
            ]),
            .episodes(character.episode.map({RMCharacterEpisodeCellViewModel(episodeDataUrl: URL(string: $0))}))
        ]
    }
    
    var sections = [SectionType]()
    
    var title: String {
        return character.name
    }
    
    public var url: URL? {
        return URL(string: character.url)
    }
    
    public func createPhotoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInformationLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 10, bottom: 4, trailing: 10)
        return section
    }
    
    public func createEpisodeLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 10, leading: 4, bottom: 10, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
    }
}
