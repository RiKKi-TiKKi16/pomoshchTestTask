//
//  LandingViewController.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import UIKit

protocol LandingRouter {
    func routeToDetails(image: UIImage, description: String)
}

class LandingViewController: UIViewController {

    var router: LandingRouter?
    var dataWorker: LandingWorkerType?
    var imageWorker: DataWorkerType?
    
    private var allDataIsLoad = false
    private var data = [LandingTableItem]()
    
    // Image caching
    private var imageDataCache = [URL: UIImage]()
    private var visibleCells = [URL: UITableViewCell]()
    
    private var rootView: LandingRootView {
        return view as! LandingRootView
    }
    
    override func loadView() {
        self.view = LandingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Landing"
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        loadData()
    }
    
    private func loadData() {
        guard !allDataIsLoad else { return }
        
        dataWorker?.loadPage(completion: {[weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                self?.rootView.tableView.reloadData()
                self?.allDataIsLoad = data.isEmpty
                
            case .failure(let error): print(error.localizedDescription)
            }
        })
    }
    
    private func loadImage(url: URL) {
        
        guard imageDataCache[url] == nil else { return }
        
        imageWorker?.loadData(url: url, completion: {[url, weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.global().async {
                    let image = UIImage(data: data)//?.resize(to: CGSize(width: 30, height: 30))
                    DispatchQueue.main.async {
                        self?.imageDataCache[url] = image
                        guard let cell = self?.visibleCells[url] else { return }
                        guard let indexPath = self?.rootView.tableView.indexPath(for: cell) else { return }
                        self?.rootView.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                }
                
            case .failure(let error):
                print("Load image error: \(error.localizedDescription)")
            }
        })
    }
    
}

extension LandingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LandingItemCell.identy) as? LandingItemCell else { return .init() }
        
        cell.title.text = item.title
        
        if let url = item.imageURL, let image = imageDataCache[url] {
            cell.image.image = image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let url = data[indexPath.row].imageURL {
            visibleCells[url] = cell
            loadImage(url: url)
        }
        
        guard indexPath.row + 5 == data.count else { return }
        loadData()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.imageView?.image = nil
        if let url = data[indexPath.row].imageURL {
            visibleCells[url] = nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
        
        let image: UIImage
        
        if let url = item.imageURL, let temp = imageDataCache[url] {
            image = temp
        } else {
            image = UIImage()
        }
        
        router?.routeToDetails(image: image, description: item.title)
    }
}

