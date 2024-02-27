//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 26/02/2024.
//

import Foundation

struct FAQResponse: Codable {
    let extTransactionID: String?
    let faqsDetails: [FaqsResponseDetail]?

    enum CodingKeys: String, CodingKey {
        case extTransactionID = "extTransactionId"
        case faqsDetails
    }
}

// MARK: - FaqsDetail
struct FaqsResponseDetail: Codable {
    let id: Int?
    let faqTitle, faqContent: String?

    enum CodingKeys: String, CodingKey {
        case id
        case faqTitle = "faq_title"
        case faqContent = "faq_content"
    }
}
