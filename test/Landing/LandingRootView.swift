//
//  LandingRootView.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import UIKit

protocol LandingRootView: UIView {
    var tableView: UITableView { get }
}

class LandingView: UIView, LandingRootView {

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.register(LandingItemCell.self, forCellReuseIdentifier: LandingItemCell.identy)
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return view
    }()

    private lazy var configure: Void = {
        backgroundColor = .white
        _ = tableView
    }()
    
    override func didMoveToWindow() {
        _ = configure
    }
    
}
