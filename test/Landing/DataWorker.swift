//
//  ImageWorker.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import UIKit.UIImage

protocol DataWorkerType {
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> ())
}

class DataWorker: DataWorkerType {
    
    private let api: URLSession
    
    init(api: URLSession) {
        self.api = api
    }
    
    func loadData(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        api.dataTask(with: URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)) { data, _, error in
            if let data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
