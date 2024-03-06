//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 23/02/2024.
//

import Foundation

enum AboutSmilesEndpoint {
    case offers
    case faqs
    
    var url: String {
        switch self {
        case .offers:
            return "home/v1/about-smiles-stories"
        case .faqs:
            return "faq/get-Faqs-details"
        }
    }
}
