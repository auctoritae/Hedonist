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
    func presentSearchFilter(response: [Landmark], filter: String)
    func presentError()
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
    
    
    func presentSearchFilter(response: [Landmark], filter: String) {
        let filter = filter
        let viewModel = response

        if filter == "all" {
            view?.displayLandmarks(viewModel: viewModel)
        } else {
            view?.displaySearchFilter(viewModel: viewModel, filter: filter)
        }
    }
    
    
    func presentError() {
        view?.displayError()
    }
}
