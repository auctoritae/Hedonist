//
//  PlacePresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlacePresenterProtocol: AnyObject {
    func presentPlace(response: Landmark)
    func addToFavorites(response: Landmark)
    func removeFromFavorites(response: Place)
    func presentSMM(response: Landmark)
    func presentCall(response: Landmark)
    func close()
}

final class PlacePresenter: PlacePresenterProtocol {
    // MARK: - Variable
    weak var view: PlaceViewProtocol?
    
    
    // MARK: - Implementation
    func presentPlace(response: Landmark) {
        let viewModel = response
        view?.displayPlace(viewModel: viewModel)
    }
    
    
    func addToFavorites(response: Landmark) {
        
    }
    
    
    func removeFromFavorites(response: Place) {
        
    }
    
    
    func presentSMM(response: Landmark) {
        let viewModel = response
        view?.displaySMM(viewModel: viewModel)
    }
    
    
    func presentCall(response: Landmark) {
        let viewModel = response
        view?.displayCall(viewModel: viewModel)
    }
    
    
    func close() {
        view?.closeScene()
    }
}
