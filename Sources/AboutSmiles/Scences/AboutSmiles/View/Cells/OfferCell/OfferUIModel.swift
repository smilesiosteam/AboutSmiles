//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 26/02/2024.
//

import Foundation

struct OfferUIModel: Equatable {
    var title: String?
    var image: String?
    var backgroundColor: String?
    var stories: [StoriesUIModel] = []
}

public struct StoriesUIModel: Equatable {
    var title: String?
    var description: String?
    var imageUrl: String?
    var buttonOneUrl: String?
    var buttonOneText: String?
    var buttonSecondText: String?
    var backgroundColor: String?
    var isActive: Bool?
}
