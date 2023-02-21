//
//  FavsPresenter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol FavsPresenterProtocol: AnyObject {
    func presentFavorites(response: [Place])
    func presentFavorite(response: [Place])
}

final class FavsPresenter: FavsPresenterProtocol {
    // MARK: - Variable
    weak var view: FavsViewProtocol?
    
    
    // MARK: - Implementation
    func presentFavorites(response: [Place]) {
        let viewModel = response
        view?.dispalyFavorites(viewModel: viewModel)
    }
    
    
    func presentFavorite(response: [Place]) {
        view?.displayFavorite(viewModel: response.map { viewModel -> Landmark in
            Landmark(
                category: viewModel.category,
                name: viewModel.name,
                address: viewModel.address,
                lat: viewModel.lat,
                long: viewModel.long,
                descript: viewModel.descript,
                phone: viewModel.phone,
                workhours: viewModel.workhours,
                image: viewModel.picture,
                url: viewModel.smm
            )
        })
    }
}
