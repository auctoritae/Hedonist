//
//  PlacePresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlacePresenterProtocol: AnyObject {
    func presentPlace(response: Landmark, favorite: Bool)
    func addToFavorites(favorite: Bool)
    func removeFromFavorites(favorite: Bool)
    func presentCall(response: Landmark)
    func close()
}

final class PlacePresenter: PlacePresenterProtocol {
    // MARK: - Variable
    weak var view: PlaceViewProtocol?
    
    
    // MARK: - Implementation
    func presentPlace(response: Landmark, favorite: Bool) {
        let viewModel = response
        view?.displayPlace(viewModel: viewModel, favorite: favorite)
    }
    
    
    func addToFavorites(favorite: Bool) {
        view?.updateStatus(favorite)
    }
    
    
    func removeFromFavorites(favorite: Bool) {
        view?.updateStatus(favorite)
    }
    
    
    func presentCall(response: Landmark) {
        let viewModel = response
        view?.displayCall(viewModel: viewModel)
    }
    
    
    func close() {
        view?.closeScene()
    }
}
