//
//  Api.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import Apollo
import PomoschAPI

class API {
    
    private let apolo: ApolloClient
    
    init() {
        let url = URL(string: "https://api.pomosch.app/graphql")!
        apolo = ApolloClient(url: url)
    }
    
    func fetch<Q: GraphQLQuery>(query: Q, resultHandler: @escaping ((Result<GraphQLResult<Q.Data>, any Error>) -> Void)) {
        apolo.fetch(query: query, resultHandler: resultHandler)
    }
    
}
