//
//  MainViewModel.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 03.12.2022.
//

import Foundation

class MainViewModel {
    
    var networkManager: NetworkManager
    var items: [Items] = []
    var sortedItems: [Items] = []
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadImageWhenTextChanges(_ searchText: String, completion: @escaping () -> Void, failureCompletion: @escaping (NetworkError) -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.networkManager.makeRequest(tag: searchText) { result in
                switch result {
                case .success(let items):
                    self?.items += items
                    self?.sortedItems += items
                    completion()
                case .failure(let error):
                    failureCompletion(error)
                }
            }
        }
    }
}
