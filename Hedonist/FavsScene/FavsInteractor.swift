//
//  FavsInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol FavsInteractorProtocol: AnyObject {
    func fetchFavorites()
    func selectFavorite(request: [Place])
}

final class FavsInteractor: FavsInteractorProtocol {
    // MARK: - Variable
    var presenter: FavsPresenterProtocol?
    private var dataManager: DataManager
    
    
    // MARK: - Init
    required init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    
    // MARK: - Implementation
    func fetchFavorites() {
        let response = dataManager.fetchPlaces()
        presenter?.presentFavorites(response: response)
    }
    
    
    func selectFavorite(request: [Place]) {
        let response = request
        presenter?.presentFavorite(response: response)
    }
}
