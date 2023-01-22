//
//  MapPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MapPresenterProtocol: AnyObject {
    func presentLandmarks(response: [Landmark])
    func presentLandmark(response: Landmark)
}

final class MapPresenter: MapPresenterProtocol {
    // MARK: - Variable
    weak var view: MapViewProtocol?
    
    
    // MARK: - Implementation
    func presentLandmarks(response: [Landmark]) {
        let viewModel = response
        view?.displayLandmarks(viewModel: viewModel)
    }
    
    
    func presentLandmark(response: Landmark) {
        let viewModel = response
        view?.displayLandmark(viewModel: viewModel)
    }
}
