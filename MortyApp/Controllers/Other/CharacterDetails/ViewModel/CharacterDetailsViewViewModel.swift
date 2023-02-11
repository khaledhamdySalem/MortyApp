//
//  CharacterDetailsViewViewModel.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import UIKit

final class CharacterDetailsViewViewModel {
    
    private let character: RMCharacter
    
    enum SectionType {
        case photo(_ viewModel: RMCharacterPhotoCellViewModel)
        case information(_ viewModel: [RMCharacterInformationCellViewModel])
        case episodes(_ viewModel: [RMCharacterEpisodeCellViewModel])
    }
    
    /*
     let id: Int
     let name: String
     let status: RMCharacterStatus
     let species: String
     let type: String
     let gender: RMCharacterGender
     let origin: RMOrigin
     let location: RMSingleLocation
     let image: String
     let episode: [String]
     let url: String
     let created: String
     */
    
    init(character: RMCharacter) {
        self.character = character
        setSections()
    }
    
    private func setSections() {
        sections = [
            .photo(.init(imageString: character.image)),
            .information([
                .init(title: character.status.text, value: "Status"),
                .init(title: character.gender.rawValue, value: "Gender"),
                .init(title: character.type, value: "Type"),
                .init(title: character.species, value: "Species"),
                .init(title: character.origin.name, value: "Origin"),
                .init(title: character.location.name, value: "Location"),
                .init(title: character.created, value: "Created"),
                .init(title: "\(character.episode.count)", value: "Total Episode")
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
        item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
        
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
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodeLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = .init(top: 10, leading: 8, bottom: 10, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
