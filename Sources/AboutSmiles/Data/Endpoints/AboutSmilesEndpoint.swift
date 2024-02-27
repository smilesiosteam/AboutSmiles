//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 23/02/2024.
//

import Foundation

enum AboutSmilesEndpoint {
    case stories
    case faqs
    
    var url: String {
        switch self {
        case .stories:
            return "home/v1/about-smiles-stories"
        case .faqs:
            return "faq/get-Faqs-details"
        }
    }
}
