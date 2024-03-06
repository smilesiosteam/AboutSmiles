//
//  File.swift
//
//
//  Created by Ahmed Naguib on 23/02/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesSharedServices

protocol AboutSmilesRepositoryProtocol {
    func fetchFaqs() -> AnyPublisher<FAQResponse, NetworkError>
    func fetchOffers() -> AnyPublisher<AboutSmilesStoryListResponse, NetworkError>
}

final class AboutSmilesRepository {
    
    // MARK: - Properties
    private let networkRequest: Requestable
    
    // MARK: - Init
    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }
}

// MARK: - Extension
extension AboutSmilesRepository: AboutSmilesRepositoryProtocol {
   
    func fetchFaqs() -> AnyPublisher<FAQResponse, NetworkError> {
        let requestModel = FAQsDetailsRequest(faqId: 12)
        let request = AboutSmilesRequest.getFaqs(request: requestModel).createRequest(endPoint: .faqs)
        return networkRequest.request(request)
    }
    
    func fetchOffers() -> AnyPublisher<AboutSmilesStoryListResponse, NetworkError> {
        let request = AboutSmilesRequest.getOffers(request: .init()).createRequest(endPoint: .offers)
        return networkRequest.request(request)
    }
}
