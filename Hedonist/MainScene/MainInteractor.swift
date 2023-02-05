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
        api.fetchData { [weak self] (result, error) in
            if let data = result {
                let response = data.record
                self?.presenter?.presentLandmarks(response: response)
            }
            
            if let error = error {
                debugPrint(error.localizedDescription)
                self?.presenter?.presentError()
            }
        }
    }
    
    
    func selectLandmark(request: Landmark) {
        let response = request
        presenter?.presentLandmark(response: response)
    }
    
    
    func selectSearchFilter(filter: String) {
        let filter = filter
        
        api.fetchData { [weak self] (result, error) in
            if let data = result {
                let response = data.record
                self?.presenter?.presentSearchFilter(response: response, filter: filter)
            }
            
            if let error = error {
                debugPrint(error.localizedDescription)
                self?.presenter?.presentError()
            }
        }
    }
}
