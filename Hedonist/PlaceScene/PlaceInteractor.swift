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
    func openMap(request: Landmark)
    func dismissView()
}

final class PlaceInteractor: PlaceInteractorProtocol {
    // MARK: - Variable
    var presenter: PlacePresenterProtocol?
    
    
    // MARK: - Implementation
    func fetchPlace(request: Landmark) { }
    func addToFavorites(request: Landmark) { }
    func removeFromFavorites(request: Landmark) { }
    func openSMM(request: Landmark) { }
    func call(request: Landmark) { }
    func openMap(request: Landmark) { }
    func dismissView() { }
}
