//
//  LandingWorker.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import Apollo
import PomoschAPI

protocol LandingWorkerType {
    func loadPage(completion: @escaping (Result<[LandingTableItem], Error>) -> ())
}

class LandingWorker: LandingWorkerType {
    
    let pageSize: Int
    
    private var cursor: String?
    private var hasNextPage = true
    
    private let api: API
    
    init(api: API, pageSize: Int = 10) {
        self.api = api
        self.pageSize = pageSize
    }
    
    func loadPage(completion: @escaping (Result<[LandingTableItem], Error>) -> ()) {
        
        guard hasNextPage else {
            completion(.success([]))
            return
        }
        
        let query = SearchQuery(first: pageSize,
                                after: cursor != nil ? .some(cursor!) : .none)
        api.fetch(query: query) {[weak self] result in
            switch result {
            case .success(let data):
                
                if let search = data.data?.search,
                    let nodes = search.nodes {
                    
                    self?.cursor = search.pageInfo.endCursor
                    
                    let items = nodes.compactMap({ node -> LandingTableItem? in
                        guard let node = node else { return nil }
                        return LandingTableItem(node: node)
                    })
                    
                    completion(.success(items))
                    
                } else if let error = data.errors?.first {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

fileprivate extension LandingTableItem {
    typealias Node = SearchQuery.Data.Search.Node
    
    init?(node: Node) {
        if let special = node.asSpecialProjectSearchResultItem {
            
            self.id = special.specialProject.id
            self.title = special.specialProject.title
            
            if let urlString = special.specialProject.images.first?.url {
                self.imageURL = URL(string: urlString)
            } else {
                self.imageURL = nil
            }
            
        } else if let ward = node.asWardSearchResultItem {
            
            self.id = ward.ward.id
            self.title = ward.ward.publicInformation.name.displayName
            self.imageURL = URL(string: ward.ward.publicInformation.photo.url)
            
        } else {
            return nil
        }
    }
}
