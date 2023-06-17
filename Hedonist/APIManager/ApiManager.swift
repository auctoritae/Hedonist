//
//  ApiManager.swift
//  Hedonist
//
//  Created by a.lobanov on 1/1/23.
//

import Foundation
import Alamofire

protocol ApiManagerProtocol: AnyObject {
    func fetchData() async throws -> Record
}

final class ApiManager: ApiManagerProtocol {
    // MARK: - Variable
    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = false
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return Session(configuration: configuration)
    }()
    
    
    // MARK: - Implementation
    func fetchData() async throws -> Record {
        let url = URLs.requestURL
        let key = APIKey.masterKey
        let headers: HTTPHeaders = ["X-MASTER-KEY" : key]
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: .get, headers: headers).validate().responseDecodable(of: Record.self) { response in
                if let result = response.value {
                    continuation.resume(returning: result)
                }
                
                if let error = response.error {
                    debugPrint(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
