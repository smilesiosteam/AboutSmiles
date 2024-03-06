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

}
