//
//  DetailView.swift
//  test
//
//  Created by Anna Ruslanovna on 11.07.2024.
//

import UIKit

protocol DetailRootView: UIView {
    var imageView: UIImageView { get }
    var descriptionLabel: UILabel { get }
}

class DetailView: UIView, DetailRootView {

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        
        view.numberOfLines = 0
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: 20)
        ])
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.height / 2
    }
    
    private lazy var configure: Void = {
        backgroundColor = .white
        _ = imageView
        
    }()
    
    override func didMoveToWindow() {
        _ = configure
    }
}
