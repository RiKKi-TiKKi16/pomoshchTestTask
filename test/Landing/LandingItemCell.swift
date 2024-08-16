//
//  LandingItemCell.swift
//  test
//
//  Created by Anna Ruslanovna on 11.07.2024.
//

import UIKit

class LandingItemCell: UITableViewCell {
    static let identy = "LandingItemCell"
    
    lazy var image: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            view.heightAnchor.constraint(equalToConstant: 50),
            view.widthAnchor.constraint(equalTo: view.heightAnchor),
            view.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            view.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 15),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: 15)
        ])
            
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.numberOfLines = 0
        
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 15),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15)
        ])
            
        return view
    }()
    
    override func prepareForReuse() {
        image.image = nil
        title.text = nil
    }
    
    private lazy var configure: Void = {
        _ = image
        _ = title
    }()
    
    override func didMoveToWindow() {
        _ = configure
    }

}
