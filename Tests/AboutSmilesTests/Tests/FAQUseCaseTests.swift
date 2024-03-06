//
//  FAQUseCaseTests.swift
//  
//
//  Created by Ahmed Naguib on 01/03/2024.
//

import XCTest
import SmilesTests
@testable import AboutSmiles

final class FAQUseCaseTests: XCTestCase {
    // MARK: - Properties
    private var sut: FAQUseCase!
    private var repository: MockAboutSmilesRepository!
    
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        repository = MockAboutSmilesRepository()
        sut = FAQUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        repository = nil
        sut = nil
    }
    
    // MARK: - Test Cases
    func test_fetchFAQs_successResponse() throws {
        
        // Given
        let response = AboutSmilesStubs.getFAQResponse
        repository.requestFaqsResult = .success(response)
        // When
        let result = try awaitPublisher(sut.fetchFAQs())
        // Then
        let expectedResult = FAQUseCase.State.success(faqs: AboutSmilesStubs.getFAQUIModels)
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_fetchFAQs_failureResponse() throws {
        // Given
        let response = AboutSmilesStubs.getFAQResponse
        repository.requestFaqsResult = .failure(.badURL(AboutSmilesStubs.errorMessage))
        // When
        let result = try awaitPublisher(sut.fetchFAQs())
        // Then
        let expectedResult = FAQUseCase.State.showError(message: AboutSmilesStubs.errorMessage)
        XCTAssertEqual(result, expectedResult)
    }
}
