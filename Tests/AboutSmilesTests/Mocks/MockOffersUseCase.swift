//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 29/02/2024.
//

import Foundation
import Combine
@testable import AboutSmiles

final class MockOffersUseCase: OffersUseCaseProtocol {
    
    // MARK: - Properties
    var fetchStoriesState: Result<OffersUseCase.State, Never> = .success(.showError(message: AboutSmilesStubs.errorMessage))
    
    // MARK: - Functions
    func fetchStories() -> AnyPublisher<OffersUseCase.State, Never> {
        Result.Publisher(fetchStoriesState)
            .eraseToAnyPublisher()
    }
}
