//
//  PlaceInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlaceInteractorProtocol: AnyObject {
    func fetchPlace(request: Landmark)
    func addToFavorites(request: Landmark)
    func removeFromFavorites(request: Landmark)
    func openSMM(request: Landmark)
    func call(request: Landmark)
    func close()
}

final class PlaceInteractor: PlaceInteractorProtocol {
    // MARK: - Variable
    var presenter: PlacePresenterProtocol?
    private var dataManager: DataManager
    
    
    // MARK: - Init
    required init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    
    // MARK: - Implementation
    func fetchPlace(request: Landmark) {
        let response = request
        let favorites = dataManager.fetchPlaces()
        let checker = favorites.map { $0.name }
        let status = checker.contains(where: { $0 == request.name })
        presenter?.presentPlace(response: response, favorite: status)
    }
    
    
    func addToFavorites(request: Landmark) {
        dataManager.add(landmark: request)
        presenter?.addToFavorites(favorite: true)
    }
    
    
    func removeFromFavorites(request: Landmark) {
        let favorites = dataManager.fetchPlaces()
        if let object = favorites.first(where: { $0.name == request.name }) {
            dataManager.delete(object: object)
            presenter?.addToFavorites(favorite: false)
        }
    }
    
    
    func openSMM(request: Landmark) {
        let response = request
        presenter?.presentSMM(response: response)
    }
    
    
    func call(request: Landmark) {
        let response = request
        presenter?.presentCall(response: response)
    }
    
    
    func close() {
        presenter?.close()
    }
}
