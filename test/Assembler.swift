//
//  Assembler.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import UIKit

protocol StartAssebler {
    func createNavController() -> UINavigationController
    func createStartScreen() -> UIViewController
}

protocol DetailAssembler {
    func createDetailViewController(model: DetailModel) -> UIViewController
}

class MainAssembler: StartAssebler {
    
    let api: API
    let session: URLSession
    weak var router: MainRouter!
    
    init(api: API, session: URLSession) {
        self.api = api
        self.session = session
    }
    
    func createNavController() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: createStartScreen())
        
        navVC.navigationBar.isTranslucent = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navVC.navigationBar.standardAppearance = appearance
        navVC.navigationBar.scrollEdgeAppearance = appearance
        
        return navVC
    }
    
    func createStartScreen() -> UIViewController {
        let vc = LandingViewController()
        
        vc.router = router
        vc.dataWorker = LandingWorker(api: api)
        vc.imageWorker = DataWorker(api: session)
        
        return vc
    }
    
}

extension MainAssembler: DetailAssembler {
    func createDetailViewController(model: DetailModel) -> UIViewController {
        let vc = DetailViewController(model: model)
        return vc
    }
}
