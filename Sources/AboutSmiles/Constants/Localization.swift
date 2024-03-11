//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 22/02/2024.
//

import Foundation

enum Localization {
    case offersTitle
    case faqsTitle
    
    var text: String {
        switch self {
        case .offersTitle:
            return "DiscoverOffers".localizedString
        case .faqsTitle:
            return "StillHaveQuestions".localizedString
        }
    }
}
