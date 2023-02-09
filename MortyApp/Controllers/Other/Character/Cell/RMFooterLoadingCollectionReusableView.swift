//
//  RMFooterLoadingCollectionReusableView.swift
//  MortyApp
//
//  Created by KH on 08/02/2023.
//

import UIKit

class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "RMFooterLoadingCollectionReusableView"
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraint()
    }
    
    private func configureView() {
        backgroundColor = .systemBackground
        addSubview(spinner)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    public func startAnimation() {
        spinner.startAnimating() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


