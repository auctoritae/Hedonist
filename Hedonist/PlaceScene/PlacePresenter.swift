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
    func removeFromFavorites(response: Landmark)
    func presentSMM(response: Landmark)
    func presentCall(response: Landmark)
    func presentMap(response: Landmark)
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
    
    func removeFromFavorites(response: Landmark) {
        
    }
    
    func presentSMM(response: Landmark) {
        let viewModel = response
        view?.displaySMM(viewModel: viewModel)
    }
    
    func presentCall(response: Landmark) {
        let viewModel = response
        view?.displayCall(viewModel: viewModel)
    }
    
    func presentMap(response: Landmark) {
        let viewModel = response
        view?.displayMap(viewModel: viewModel)
    }
}
