//
//  FavsPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol FavsPresenterProtocol: AnyObject {
    func presentFavorites(response: [Place])
    func presentFavorite(response: Place)
    func removeFavorite(response: Place)
}

final class FavsPresenter: FavsPresenterProtocol {
    // MARK: - Variable
    weak var view: FavsViewProtocol?
    
    
    // MARK: - Implementation
    func presentFavorites(response: [Place]) {
        let viewModel = response
        view?.dispalyFavorites(viewModel: viewModel)
    }
    
    
    func presentFavorite(response: Place) {
        
    }
    
    
    func removeFavorite(response: Place) {
        
    }
}
