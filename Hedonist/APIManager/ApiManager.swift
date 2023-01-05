//
//  ApiManager.swift
//  Hedonist
//
//  Created by a.lobanov on 1/1/23.
//

import Foundation
import Alamofire

protocol ApiManagerProtocol: AnyObject {
    func fetchData(completion: @escaping ((Record?) -> Void))
}

final class ApiManager: ApiManagerProtocol {
    // MARK: - Variable
    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        return Session(configuration: configuration)
    }()
    
    
    // MARK: - Implementation
    func fetchData(completion: @escaping ((Record?) -> Void)) {
        let url = URLs.requestURL
        let key = APIKey.masterKey
        let headers: HTTPHeaders = ["X-MASTER-KEY" : key]
        
        session.request(url, method: .get, headers: headers).validate().responseDecodable(of: Record.self) { response in
            if let result = response.value {
                completion(result)
            }
            
            if let error = response.error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
