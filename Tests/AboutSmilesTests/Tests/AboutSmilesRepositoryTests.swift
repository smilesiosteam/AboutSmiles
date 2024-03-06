//
//  AboutSmilesRepositoryTests.swift
//
//
//  Created by Ahmed Naguib on 29/02/2024.
//

import XCTest
import NetworkingLayer
import SmilesSharedServices
@testable import AboutSmiles

final class AboutSmilesRepositoryTests: XCTestCase {
   
    // MARK: - Properties
    private var sut: AboutSmilesRepository!
    private var network: MockNetwork!
    
    // MARK: - Life Cycle
    override func setUpWithError() throws {
        network = .init()
        sut = .init(networkRequest: network)
    }
    
    override func tearDownWithError() throws {
        network = nil
        sut = nil
    }
    
    // MARK: - Test Cases
    func test_fetchFaqs_isCalledRequest() {
        // Given
        let requestModel = FAQsDetailsRequest(faqId: 9)
        let request: NetworkRequest = AboutSmilesRequest.getFaqs(request: requestModel).createRequest(endPoint: .faqs)
        
        // When
        let _ =  sut.fetchFaqs()
        // Then
        XCTAssertTrue(network.isCalledRequest)
        XCTAssertEqual(network.request, request)
    }
    
    func test_fetchOffers_isCalledRequest() {
        // Given
        let request = AboutSmilesRequest.getOffers(request: .init()).createRequest(endPoint: .offers)
        // When
        let _ =  sut.fetchOffers()
        // Then
        XCTAssertTrue(network.isCalledRequest)
        XCTAssertEqual(network.request, request)
    }
}
