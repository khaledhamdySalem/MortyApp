//
//  CharacterDetailsViewController.swift
//  MortyApp
//
//  Created by KH on 07/02/2023.
//

import UIKit

class RMCharacterDetailsViewController: UIViewController {
    
//    private var character = RMCharacter()
     
    private let viewModel: CharacterDetailsViewViewModel
    
    init(viewModel: CharacterDetailsViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
