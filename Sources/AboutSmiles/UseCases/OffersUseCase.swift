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
        model.backgroundColor = item.backgroundColor
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
        model.isActive = (story.isActive ?? 0) == 1
        return model
    }
}

extension OffersUseCase {
    enum State: Equatable {
        case success(offers: [OfferUIModel])
        case showError(message: String)
    }
}
