//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 26/02/2024.
//

import Foundation

struct OfferUIModel {
    var title: String?
    var storyImage: String?
    var backgroundColor: String?
    var stories: [StoriesUIModel] = []
}

struct StoriesUIModel {
    var title: String?
    var description: String?
    var imageUrl: String?
    var buttonOneUrl: String?
    var buttonOneText: String?
    var buttonSecondText: String?
    var backgroundColor: String?
}
