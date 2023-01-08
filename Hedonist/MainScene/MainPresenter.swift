//
//  MainPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func presentLandmarks(response: [Landmark])
    func presentLandmark(response: Landmark)
    func presentSearchFilter(response: String)
}

final class MainPresenter: MainPresenterProtocol {
    // MARK: - Variable
    weak var view: MainViewProtocol?
    
    
    // MARK: - Implementation
    func presentLandmarks(response: [Landmark]) {
        let viewModel = response
        view?.displayLandmarks(viewModel: viewModel)
    }
    
    
    func presentLandmark(response: Landmark) {
        let landmark = response
        view?.displayLandmark(viewModel: landmark)
    }
    
    
    func presentSearchFilter(response: String) {
        let item = response
        view?.displaySearchFilter(category: item)
    }
}
