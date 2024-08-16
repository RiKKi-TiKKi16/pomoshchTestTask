//
//  Router.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import UIKit

protocol StartRouter {
    func start()
}

typealias Assembler = StartAssebler & DetailAssembler

class MainRouter: StartRouter {
    
    let window: UIWindow
    let assembler: Assembler
    
    var rootNavController: UINavigationController!
    
    init(window: UIWindow, assembler: Assembler) {
        self.window = window
        self.assembler = assembler
    }
    
    func start() {
        rootNavController = assembler.createNavController()
        window.rootViewController = rootNavController
        window.makeKeyAndVisible()
    }
    
}

extension MainRouter: LandingRouter {
    func routeToDetails(image: UIImage, description: String) {
        let vc = assembler.createDetailViewController(model: DetailModel(image: image, description: description))
        rootNavController.present(vc, animated: true)
    }
}
