//
//  File.swift
//
//
//  Created by Ahmed Naguib on 29/02/2024.
//

import Foundation
import NetworkingLayer
import Combine
@testable import AboutSmiles

final class MockAboutSmilesRepository: AboutSmilesRepositoryProtocol {
    // MARK: - Properties
    var requestFaqsResult: Result<FAQResponse, NetworkError> = .failure(.badURL(AboutSmilesStubs.errorMessage))
    var requestOffersResult: Result<AboutSmilesStoryListResponse, NetworkError> = .failure(.badURL(AboutSmilesStubs.errorMessage))
    
    // MARK: - Functions
    func fetchFaqs() -> AnyPublisher<FAQResponse, NetworkError> {
        Result.Publisher(requestFaqsResult)
            .eraseToAnyPublisher()
    }
    
    func fetchOffers() -> AnyPublisher<AboutSmilesStoryListResponse, NetworkError> {
        Result.Publisher(requestOffersResult)
            .eraseToAnyPublisher()
    }
}
