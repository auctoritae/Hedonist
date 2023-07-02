//
//  MainInteractor.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {
    func fetchLandmarks()
    func selectLandmark(request: Landmark)
    func selectSearchFilter(filter: String)
}

final class MainInteractor: MainInteractorProtocol {
    // MARK: - Variable
    var presenter: MainPresenterProtocol?
    private var api: ApiManager
    
    
    // MARK: - Init
    required init(api: ApiManager) {
        self.api = api
    }
    
    
    // MARK: - Implementation
    func fetchLandmarks() {
        Task {
            do {
                let data = try await api.fetchData()
                let response = data.record
                presenter?.presentLandmarks(response: response)
            } catch {
                presenter?.presentError()
            }
        }
    }
    
    
    func selectLandmark(request: Landmark) {
        let response = request
        presenter?.presentLandmark(response: response)
    }
    
    
    func selectSearchFilter(filter: String) {
        let filter = filter
        
        Task {
            do {
                let data = try await api.fetchData()
                let response = data.record
                presenter?.presentSearchFilter(response: response, filter: filter)
            } catch {
                presenter?.presentError()
            }
        }
    }
}
