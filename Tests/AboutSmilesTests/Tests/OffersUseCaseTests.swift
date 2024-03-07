//
//  OffersUseCaseTests.swift
//  
//
//  Created by Ahmed Naguib on 01/03/2024.
//

import XCTest
import SmilesTests
@testable import AboutSmiles

final class OffersUseCaseTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: OffersUseCase!
    private var repository: MockAboutSmilesRepository!
    
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        repository = MockAboutSmilesRepository()
        sut = OffersUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        repository = nil
        sut = nil
    }
    
    // MARK: - Test Cases
    func test_fetchFAQs_successResponse() throws {
        // Given
        let response = AboutSmilesStubs.getOffersResponse
        repository.requestOffersResult = .success(response)
        // When
        let result = try awaitPublisher(sut.fetchStories())
        // Then
        let expectedResult = OffersUseCase.State.success(offers: AboutSmilesStubs.getOfferUIModel)
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_fetchFAQs_failureResponse() throws {
        // Given
        repository.requestOffersResult = .failure(.badURL(AboutSmilesStubs.errorMessage))
        // When
        let result = try awaitPublisher(sut.fetchStories())
        // Then
        let expectedResult = OffersUseCase.State.showError(message: AboutSmilesStubs.errorMessage)
        XCTAssertEqual(result, expectedResult)
    }
}
