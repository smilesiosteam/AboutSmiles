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
    
    static var getOffersResponse: AboutSmilesStoryListResponse {
        let model: AboutSmilesStoryListResponse? = readJsonFile("OffersRespnse", bundle: .module)
        return model ?? .init(aboutSmilesStory: [])
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
    
    static var getOfferUIModel: [OfferUIModel] {
        [
            .init(title: "What is New",
                  image: "https://www.smilesuae.ae/images/APP/storyImage.png",
                  stories: [
                    .init(title: "Explore the best of UAE with Smiles Explorer",
                          description: "Descriptive benefits English",
                          imageUrl: "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
                          buttonOneUrl: "https://www.smilesuae.ae",
                          buttonOneText: "Go to Smiles Explorer",
                          buttonSecondText: "Next",
                          backgroundColor: "#DCDFEF")]),
            
                .init(title: "What is Smiles?",
                      image: "https://www.smilesuae.ae/images/APP/storyImage.png",
                      stories: [
                        .init(title: "Get your car insured with 1 easy steps",
                              description: "Descriptive benefits English",
                              imageUrl: "https://www.smilesuae.ae/images/APP/SMALL/storyImage.png",
                              buttonOneUrl: "https://www.smilesuae.ae",
                              buttonOneText: "Explore Car Insurance",
                              buttonSecondText: "Next",
                              backgroundColor: "#DCDFEF"),
                        
                        .init(title: "Get your car insured with 2 easy steps",
                              description: "Descriptive benefits English",
                              imageUrl: "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
                              buttonOneUrl: "https://www.smilesuae.ae",
                              buttonOneText: "Explore Car Insurance",
                              buttonSecondText: "Next")
                      
                      ]),
            
            
        ]
    }
}
