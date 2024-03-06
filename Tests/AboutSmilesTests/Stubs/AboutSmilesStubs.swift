//
//  File.swift
//
//
//  Created by Ahmed Naguib on 29/02/2024.
//

import Foundation
import SmilesTests
@testable import AboutSmiles

enum AboutSmilesStubs {
    static let errorMessage = "Internal server error"
    
    static var getFAQResponse: FAQResponse {
        let model: FAQResponse? = readJsonFile("FaqResponse", bundle: .module)
        return model ?? .init()
    }
    
    static var getFAQUIModels: [QuestionCollectionViewCell.ViewModel] {
        [
            .init(question: "How to pay for the MCFC subscription?",
                  answer: "<p>You can pay using Smiles points, Card or Points+Card.</p>",
                  id: 36),
            .init(question: "What is the validity of subscription to MCFC?",
                  answer: "<p>Lifetime. It is a one-time subscription package.</p>",
                  id: 37)
        ]
    }
}
