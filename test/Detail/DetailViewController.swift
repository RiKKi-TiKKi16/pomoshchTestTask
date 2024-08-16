//
//  DetailViewController.swift
//  test
//
//  Created by Anna Ruslanovna on 11.07.2024.
//

import UIKit

class DetailViewController: UITabBarController {

    let model: DetailModel
    
    init(model: DetailModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rootView: DetailRootView {
        return view as! DetailRootView
    }
    
    override func loadView() {
        self.view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.imageView.image = model.image
        rootView.descriptionLabel.text = model.description
    }

}
