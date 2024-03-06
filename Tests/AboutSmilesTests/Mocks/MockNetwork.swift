//
//  File.swift
//
//
//  Created by Ahmed Naguib on 29/02/2024.
//

import Foundation
import Combine
import NetworkingLayer

final class MockNetwork: Requestable {
    
    // MARK: - Properties
    var requestResult: Result<Data, NetworkError> = .failure(.badURL(AboutSmilesStubs.errorMessage))
    var requestTimeOut: Float = 20
    var isCalledRequest = false
    var request: NetworkRequest?
    // MARK: - Functions
    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError> {
        request = req
        isCalledRequest.toggle()
        return Result.Publisher(requestResult)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                guard let apiError = error as? NetworkError else {
                    return NetworkError.badURL(AboutSmilesStubs.errorMessage)
                }
                return apiError
            }
            .eraseToAnyPublisher()
    }
}
