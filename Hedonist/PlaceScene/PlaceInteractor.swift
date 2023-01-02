//
//  PlaceInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import Foundation

protocol PlaceInteractorProtocol: AnyObject {
    func fetchPlace(request: Place)
    func addToFavorites(request: Place)
    func removeFromFavorites(request: Place)
    func openSMM(request: Place)
    func call(request: Place)
    func openMap(request: Place)
    func dismissView()
}

final class PlaceInteractor: PlaceInteractorProtocol {
    // MARK: - Variable
    var presenter: PlacePresenterProtocol?
    
    
    // MARK: - Implementation
    func fetchPlace(request: Place) { }
    func addToFavorites(request: Place) { }
    func removeFromFavorites(request: Place) { }
    func openSMM(request: Place) { }
    func call(request: Place) { }
    func openMap(request: Place) { }
    func dismissView() { }
}
