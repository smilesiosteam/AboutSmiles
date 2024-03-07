//
//  AboutSmilesViewModelTests.swift
//
//
//  Created by Ahmed Naguib on 06/03/2024.
//

import XCTest
import SmilesTests
@testable import AboutSmiles

final class AboutSmilesViewModelTests: XCTestCase {
    
    // MARK: - Properties
    private var sut: AboutSmilesViewModel!
    private var storyUseCase: MockOffersUseCase!
    private var faqsUseCase: MockFAQUseCase!
    
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        storyUseCase = .init()
        faqsUseCase = .init()
        sut = .init(faqsUseCase: faqsUseCase, storyUseCase: storyUseCase)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Test Cases
    func test_loadData_successResponse() throws {
        let result = PublisherSpy(sut.statePublisher.collectNext(2))
        // Given
        storyUseCase.fetchStoriesState = .success(.success(offers: AboutSmilesStubs.getOfferUIModel))
        faqsUseCase.fetchFAQsState = .success(.success(faqs: AboutSmilesStubs.getFAQUIModels))
        // When
        sut.loadData()
        
        // Then
        XCTAssertEqual(result.value, [.hideLoader, .success(models: [
            .offers(offers: AboutSmilesStubs.getOfferUIModel),
            .faqs(faqs: AboutSmilesStubs.getFAQUIModels)
        ])])
    }
    
    
    func test_loadData_failureResponseForBothApis() {
        let result = PublisherSpy(sut.statePublisher.collectNext(2))
        // Given
        storyUseCase.fetchStoriesState = .success(.showError(message: AboutSmilesStubs.errorMessage))
        faqsUseCase.fetchFAQsState = .success(.showError(message: AboutSmilesStubs.errorMessage))
        // When
        sut.loadData()
        
        // Then
        XCTAssertEqual(result.value, [.hideLoader, .showError(message: AboutSmilesStubs.errorMessage)])
    }
    
    func test_loadData_failureResponseForOffers() {
        let result = PublisherSpy(sut.statePublisher.collectNext(3))
        // Given
        storyUseCase.fetchStoriesState = .success(.showError(message: AboutSmilesStubs.errorMessage))
        faqsUseCase.fetchFAQsState = .success(.success(faqs: AboutSmilesStubs.getFAQUIModels))
        // When
        sut.loadData()
        
        // Then
        XCTAssertEqual(result.value, [.hideLoader,
                                      .showError(message: AboutSmilesStubs.errorMessage),
                                      .success(models: [.faqs(faqs: AboutSmilesStubs.getFAQUIModels)])
        ])
    }
    
    func test_loadData_failureResponseForFAQs() {
        let result = PublisherSpy(sut.statePublisher.collectNext(3))
        // Given
        storyUseCase.fetchStoriesState = .success(.success(offers: AboutSmilesStubs.getOfferUIModel))
        faqsUseCase.fetchFAQsState = .success(.showError(message: AboutSmilesStubs.errorMessage))
        // When
        sut.loadData()
        
        // Then
        XCTAssertEqual(result.value, [.hideLoader,
                                      .showError(message: AboutSmilesStubs.errorMessage),
                                      .success(models: [.offers(offers: AboutSmilesStubs.getOfferUIModel)])
        ])
    }
    // What is view
}
