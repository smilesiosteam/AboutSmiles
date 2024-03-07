//
//  AboutSmilesEndpointTests.swift
//  
//
//  Created by Ahmed Naguib on 07/03/2024.
//

import XCTest
@testable import AboutSmiles

final class AboutSmilesEndpointTests: XCTestCase {
    
    func test_aboutSmilesEndpoint_offers_url() {
        XCTAssertEqual(AboutSmilesEndpoint.offers.url, "home/v1/about-smiles-stories")
    }
    
    func test_aboutSmilesEndpoint_faq_url() {
        XCTAssertEqual(AboutSmilesEndpoint.faqs.url, "faq/get-Faqs-details")
    }
    
}
