//
//  File.swift
//
//
//  Created by Ahmed Naguib on 22/02/2024.
//

import Foundation
import Combine

protocol OffersUseCaseProtocol {
    func fetchStories() -> AnyPublisher<OffersUseCase.State, Never>
}

final class OffersUseCase {
    
    // MARK: - Properties
    private let repository: AboutSmilesRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(repository: AboutSmilesRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - UseCase Protocol
extension OffersUseCase: OffersUseCaseProtocol {
    
    func fetchStories() -> AnyPublisher<State, Never> {
        
        return Future<State, Never> { [weak self] promise in
            guard let self else {
                return
            }
            self.repository.fetchOffers()
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.success(.showError(message: error.localizedDescription)))
                    }
                } receiveValue: { response in
                    let response = response.aboutSmilesStory ?? []
//                    convertStringToModel(storyData)?.aboutSmilesStory ?? []
                    let offers = response.map({ self.map($0) })
                    promise(.success(.success(offers: offers)))
                }
                .store(in: &cancellables)
        }.eraseToAnyPublisher()
    }
    
    private func map(_ item: AboutSmilesStoryResponse) -> OfferUIModel {
        var model = OfferUIModel()
        model.title = item.storyTitle
        model.image = item.storyImage
        //  model.backgroundColor
        model.stories = (item.stories ?? []).map({ mapStory($0) })
        return model
    }
    
    private func mapStory(_ story: StoryResponse) -> StoriesUIModel {
        var model = StoriesUIModel()
        model.backgroundColor = story.backgroundColor
        model.buttonOneText = story.buttonOneText
        model.buttonOneUrl = story.buttonOneURL
        model.buttonSecondText = story.buttonSecondText
        model.description = story.description
        model.imageUrl = story.imageURL
        model.title = story.title
        return model
    }
}

extension OffersUseCase {
    enum State {
        case success(offers: [OfferUIModel])
        case showError(message: String)
    }
}

func convertStringToModel(_ jsonString: String) -> AboutSmilesStoryListResponse? {
    // Convert string to Data
    guard let jsonData = jsonString.data(using: .utf8) else {
        print("Failed to convert string to data.")
        return nil
    }
    
    do {
        // Use JSONDecoder to decode the data into MyModel
        let decoder = JSONDecoder()
        let myModel = try decoder.decode(AboutSmilesStoryListResponse.self, from: jsonData)
        dump(myModel)
        
        return myModel
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}

var storyData = """
{
  "aboutSmilesStory": [
    {
      "storyTitle": " What is New",
      "storyImage": "https://www.smilesuae.ae/images/APP/storyImage.png",
      "stories": [
        {
          "title": " Explore the best of UAE with Smiles Explorer",
          "description": " Descriptive benefits English",
          "imageUrl": "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
          "buttonOneUrl": "https://www.smilesuae.ae",
          "buttonOneText": "Go to Smiles Explorer",
          "buttonSecondText": "Next",
          "backgroundColor":"#DCDFEF"
        }
      ]
    },
    {
      "storyTitle": "What is Smiles?",
      "storyImage": "https://www.smilesuae.ae/images/APP/storyImage.png",
      "stories": [
        {
          "title": "Get your car insured with 1 easy steps",
          "description": " Descriptive benefits English ",
          "imageUrl": "https://www.smilesuae.ae/images/APP/SMALL/storyImage.png",
          "buttonOneUrl": " https://www.smilesuae.ae",
          "buttonOneText": "Explore Car Insurance",
          "buttonSecondText": "Next",
          "backgroundColor":"#DCDFEF"
        },
        {
          "title": "Get your car insured with 2 easy steps",
          "description": " Descriptive benefits English ",
          "imageUrl": "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
          "buttonOneUrl": " https://www.smilesuae.ae",
          "buttonOneText": "Explore Car Insurance",
          "buttonSecondText": "Next"
        },
        {
          "title": "Get your car insured with 3 easy steps",
          "description": " Descriptive benefits English ",
          "imageUrl": "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
          "buttonOneUrl": " https://www.smilesuae.ae",
          "buttonOneText": "Explore Car Insurance",
          "buttonSecondText": "Next",
          "backgroundColor":"#DCDFEF"
        },
        {
          "title": "Get your car insured with 4 easy steps",
          "description": " Descriptive benefits English ",
          "imageUrl": "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
          "buttonOneUrl": " https://www.smilesuae.ae",
          "buttonOneText": "Explore Car Insurance",
          "buttonSecondText": "Next"
        },
        {
          "title": "Get your car insured with 5 easy steps",
          "description": " Descriptive benefits English ",
          "imageUrl": "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
          "buttonOneUrl": " https://www.smilesuae.ae",
          "buttonOneText": "Explore Car Insurance",
          "buttonSecondText": "Next",
          "backgroundColor":"#DCDFEF"
        }
      ]
    },
    {
      "storyTitle": "What is Smiles?",
      "storyImage": "https://www.smilesuae.ae/images/APP/storyImage.png",
      "stories": [
        {
          "title": "Get your car insured with 3 easy steps",
          "description": " Descriptive benefits English ",
          "imageUrl": "https://www.smilesuae.ae/images/APP/ SMALL/storyImage.png",
          "buttonOneUrl": " https://www.smilesuae.ae",
          "buttonOneText": "Explore Car Insurance",
          "buttonSecondText": "Next",
          "backgroundColor":"#DCDFEF"
        }
      ]
    }
  ]
}
"""
