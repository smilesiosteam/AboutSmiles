//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 26/02/2024.
//

import Foundation

struct AboutSmilesStoryListResponse: Codable {
    let aboutSmilesStory: [AboutSmilesStoryResponse]?
}

// MARK: - AboutSmilesStory
struct AboutSmilesStoryResponse: Codable {
    let storyTitle: String?
    let storyImage: String?
    let stories: [StoryResponse]?
}

// MARK: - Story
struct StoryResponse: Codable {
    let title, description: String?
    let imageURL: String?
    let buttonOneURL: String?
    let buttonOneText, buttonSecondText: String?

    enum CodingKeys: String, CodingKey {
        case title, description
        case imageURL = "imageUrl"
        case buttonOneURL = "buttonOneUrl"
        case buttonOneText, buttonSecondText
    }
}