//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 26/02/2024.
//

import Foundation

enum AboutSmilesSections {
    case offers(offers: [OfferUIModel])
    case faqs(faqs: [QuestionCollectionViewCell.ViewModel])
    
    var title: String {
        switch self {
        case .offers:
            Localization.offersTitle.text
        case .faqs:
            Localization.faqsTitle.text
        }
    }
}
