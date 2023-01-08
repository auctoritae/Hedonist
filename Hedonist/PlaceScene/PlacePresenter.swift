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
    func dismissView() 
}

final class PlacePresenter: PlacePresenterProtocol {
    // MARK: - Variable
    weak var view: PlaceViewProtocol?
    
    
    // MARK: - Implementation
    func presentPlace(response: Landmark) { }
    func addToFavorites(response: Landmark) { }
    func removeFromFavorites(response: Landmark) { }
    func presentSMM(response: Landmark) { }
    func presentCall(response: Landmark) { }
    func presentMap(response: Landmark) { }
    func dismissView() { }
}
