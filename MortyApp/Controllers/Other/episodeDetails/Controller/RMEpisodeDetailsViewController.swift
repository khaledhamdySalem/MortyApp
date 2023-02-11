//
//  RMEpisodeDetailsViewController.swift
//  MortyApp
//
//  Created by KH on 11/02/2023.
//

import UIKit

class RMEpisodeDetailsViewController: UIViewController {
    
    private var url: URL?
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    private func configureView() {
        view.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
