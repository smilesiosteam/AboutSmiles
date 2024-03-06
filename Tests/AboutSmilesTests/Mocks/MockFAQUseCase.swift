//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 29/02/2024.
//

import Foundation
import Combine
@testable import AboutSmiles

final class MockFAQUseCase: FAQUseCaseProtocol {
    
    // MARK: - Properties
    var fetchFAQsState: Result<FAQUseCase.State, Never> = .success(.showError(message: AboutSmilesStubs.errorMessage))
    
    // MARK: - Functions
    func fetchFAQs() -> AnyPublisher<FAQUseCase.State, Never> {
        Result.Publisher(fetchFAQsState)
            .eraseToAnyPublisher()
    }
}
