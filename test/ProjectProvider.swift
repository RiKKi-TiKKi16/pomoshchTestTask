//
//  ProjectProvider.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import UIKit

class ProjectProvider {
    
    let router: StartRouter
    
    let api = API()
    let session = URLSession.shared
    
    init(window: UIWindow) {
        let assembler = MainAssembler(api: api,
                                      session: session)
        let router = MainRouter(window: window, assembler: assembler)
        assembler.router = router
        
        self.router = router
    }
    
    func start() {
        router.start()
    }
}
