//
//  MapInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MapInteractorProtocol: AnyObject {
    func fetchLandmarks()
    func selectLandmark(request: Landmark)
}

final class MapInteractor: MapInteractorProtocol {
    // MARK: - Variable
    var presenter: MapPresenterProtocol?
    private var api: ApiManager
    
    
    // MARK: - Init
    required init(api: ApiManager) {
        self.api = api
    }
    
    
    // MARK: - Implementation
    func fetchLandmarks() { }
    func selectLandmark(request: Landmark) { }
}
