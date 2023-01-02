//
//  PlacePresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlacePresenterProtocol: AnyObject {
    func presentPlace(response: Place)
    func addToFavorites(response: Place)
    func removeFromFavorites(response: Place)
    func presentSMM(response: Place)
    func presentCall(response: Place)
    func presentMap(response: Place)
    func dismissView() 
}

final class PlacePresenter: PlacePresenterProtocol {
    // MARK: - Variable
    weak var view: PlaceViewProtocol?
    
    
    // MARK: - Implementation
    func presentPlace(response: Place) { }
    func addToFavorites(response: Place) { }
    func removeFromFavorites(response: Place) { }
    func presentSMM(response: Place) { }
    func presentCall(response: Place) { }
    func presentMap(response: Place) { }
    func dismissView() { }
}
